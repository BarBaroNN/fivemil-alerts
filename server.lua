CreateThread(function()
    while true do
        PerformHttpRequest("https://www.oref.org.il/WarningMessages/History/AlertsHistory.json", function(err, text, headers) 
            if text then
                cjson = json.decode(text)
                local rtv = {}
                for k, v in pairs(cjson) do
                    year,month,day,hour,min,sec = v['alertDate']:match("(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)")
                    if os.time() - os.time({day=day,month=month,year=year,hour=hour,min=min,sec=sec}) <= 60 * 2.5 then
                        rtv[v['data']] = true
                    end
                end

                TriggerClientEvent('fivemil-alerts', -1, rtv)
            end
        end)

        Wait(3000)
    end
end)