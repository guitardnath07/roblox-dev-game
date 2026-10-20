--!strict
-- Quêtes du jour / de la semaine (profil « Quests », tirées par le serveur) : progression, « Réclamer »
-- (ClaimQuest), et boutique de quêtes payée en Tickets (BuyQuestItem).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Quests = require(ReplicatedStorage.Shared.Config.Quests)
local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)
local Types = require(ReplicatedStorage.Shared.Types)

local Controllers = script.Parent.Parent.Parent.Controllers
local DataController = require(Controllers.DataController)
local NotificationController = require(Controllers.NotificationController)

local Kit = require(script.Parent.Parent.Kit)
local Theme = require(script.Parent.Parent.Theme)
local Window = require(script.Parent.Parent.Window)

local Screen = { title = "📜 Quêtes" }

-- Appel d'un remote de récompense ({ ok, message }) affiché en notification.
local function claim(remote: RemoteFunction, ...: any)
	local args = table.pack(...)
	local ok, response = pcall(function()
		return remote:InvokeServer(table.unpack(args, 1, args.n))
	end)
	local good = ok and type(response) == "table" and response.ok
	NotificationController:Toast(
		if ok and type(response) == "table" then tostring(response.message) else "Réessaie dans un instant.",
		if good then "info" else "error"
	)
end

function Screen.build(win: Window.Window)
	local data: Types.ProfileData = DataController:Get()
	local tickets =
		Kit.title(win.content, "", { Size = UDim2.fromScale(1, 0.11), TextXAlignment = Enum.TextXAlignment.Left }, 24)
	local list = Kit.scroll(win.content, { Position = UDim2.fromScale(0, 0.13), Size = UDim2.fromScale(1, 0.87) })
	Kit.list(list, false, 0)
	Kit.new("UIPadding", { PaddingLeft = UDim.new(0.015, 0), PaddingRight = UDim.new(0.015, 0), Parent = list })

	local rowMaid = Kit.maid()
	win.maid:add(rowMaid)

	local function render()
		rowMaid:clean()
		tickets.Text = `🎟️ Tickets d'Expédition : {Kit.group(data.Tickets)}`
		local order = 0
		local function header(text: string)
			order += 1
			rowMaid:add(
				Kit.row(list, { { text = text, width = 1, font = Theme.TitleFont } }, order, 32, Theme.ParchmentDeep)
			)
		end
		local function withButton(cells: { Kit.Cell }, text: string, color: Color3, onClick: (() -> ())?)
			order += 1
			local row = Kit.row(list, cells, order, 46, if order % 2 == 0 then Theme.ParchmentDark else nil)
			rowMaid:add(row)
			local holder = Kit.new("Frame", {
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.78, 0.04),
				Size = UDim2.fromScale(0.21, 0.92),
				Parent = row,
			})
			Kit.button(holder, text, { color = color, maid = rowMaid, onClick = onClick, maxText = 16 })
		end

		local state = data.Quests or ({} :: any)
		for _, scope in { "daily", "weekly" } do
			header(if scope == "daily" then "Quêtes du jour" else "Quêtes de la semaine")
			local pool = if scope == "daily" then Quests.daily else Quests.weekly
			for index, entry in (state :: any)[scope] or {} do
				local quest = Kit.find(pool, entry.id)
				if quest then
					local done = entry.progress >= quest.target
					withButton(
						{
							{ text = (quest.displayName:gsub("{n}", Kit.group(quest.target))), width = 0.46 },
							{
								text = `{Kit.group(math.min(entry.progress, quest.target))}/{Kit.group(quest.target)}`,
								width = 0.16,
								font = Theme.NumberFont,
							},
							{ text = `+{quest.tickets} 🎟️`, width = 0.15, font = Theme.NumberFont },
						},
						if entry.claimed then "Fait ✔" elseif done then "Réclamer" else "En cours",
						if entry.claimed then Theme.LeafDark elseif done then Theme.Amber else Theme.Disabled,
						if done and not entry.claimed
							then function()
								claim(Remotes.ClaimQuest, scope, index)
							end
							else nil
					)
				end
			end
		end

		header("Boutique de quêtes")
		for _, item in Quests.shop do
			local affordable = data.Tickets >= item.priceTickets
			withButton(
				{
					{ text = item.displayName, width = 0.6 },
					{ text = `{item.priceTickets} 🎟️`, width = 0.17, font = Theme.NumberFont },
				},
				"Acheter",
				if affordable then Theme.Leaf else Theme.Disabled,
				if affordable
					then function()
						claim(Remotes.BuyQuestItem, item.id)
					end
					else nil
			)
		end
	end

	win.maid:add(DataController:OnChanged("Quests", render))
	win.maid:add(DataController:OnChanged("Tickets", render))
	render()
end

return Screen
