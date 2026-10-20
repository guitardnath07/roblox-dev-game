--!strict
-- Lance tous les tests Jest-Lua. À exécuter pendant un Play (contexte serveur), par exemple via le MCP Studio :
--   require(game.ServerScriptService.Tests.RunTests)()
-- Jest-Lua a besoin du flag Studio FFlagEnableLoadModule = true (ClientAppSettings.json).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

return function(): boolean
	local runCLI = require(ReplicatedStorage.DevPackages.Jest).runCLI
	local status, result = runCLI(script.Parent, { verbose = false, ci = false }, { script.Parent }):awaitStatus()
	if status == "Rejected" then
		warn(result)
		return false
	end
	return result.results.numFailedTests == 0 and result.results.numFailedTestSuites == 0
end
