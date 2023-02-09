MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

local list_hair = {}
local list_hair_length = 0

local hairM = {}
local hairf = {}

local list_hair_f = {}
local list_hair_f_length = 0

local list_mustache = {}
local list_mustache_length = 0

local adding = true

local sentado = false
local cabeleira = {}
local barbas = {}
local fazendobarba = false

function cabeleireiro()
MenuData.CloseAll()
local myPed = PlayerPedId()
local sex = IsPedMale(myPed)
local elements = {}
local currentHairList = {}
local currentHairListWoman = {}
local currentBeardList = {}

if sex == 1 then
    elements = {
        {label = "Cabelo", cat = "hair", value = "cabelo", desc = "Selecione Seu Novo Estilo de Cabelo"},
        {label = "Barba", cat = "mustache", value = "barba", desc = "Selecione Seu Novo Estilo de Barba"},
        {label = "Sair", value = "sair", desc = "Sair da Barbearia"},
    }
else
    elements = {
        {label = "Cabelo", cat = "hair", value = "cabelof", desc = "Selecione Seu Novo Estilo de Cabelo"},
        {label = "Sair", value = "sair", desc = "Sair da Barbearia"},
    }
end

MenuData.Open(
    'default', GetCurrentResourceName(), 'Cabeleireiro_Menu',
    {
        title    = 'Cabeleireiro',
        
        subtext    = 'Salão',

        align    = 'top-right',

        elements = elements,
    },
    function(data, menu)
        if(data.current.value) == "cabelo" then
            menu.close()
            for k in pairs(cabeleira) do
                cabeleira[k] = nil
            end
            cabelo()
            fazendobarba = false
        elseif(data.current.value) == "barba" then
            menu.close()
            for k in pairs(barbas) do
                barbas[k] = nil
            end
            barba()
            fazendobarba = true
        elseif(data.current.value) == "cabelof" then
            menu.close()
            for k in pairs(cabeleira) do
                cabeleira[k] = nil
            end
            cabelo()
        elseif(data.current.value) == "sair" then
            menu.close()
            if ClearPedTasks(PlayerPedId()) then
                Citizen.Wait(1000)
                sentado = false
                TriggerServerEvent('redemrp_skin:loadSkin')
            end
        end
    end,
    
    function(data, menu)
        menu.close()
        if ClearPedTasks(PlayerPedId()) then
            Citizen.Wait(1000)
            sentado = false
            TriggerServerEvent('redemrp_skin:loadSkin')
        end
    end)  
end

function cabelo()
MenuData.CloseAll()
local myPed = PlayerPedId()
local sex = IsPedMale(myPed)
local elements = {}
local currentHairList = {}
local currentHairListWoman = {}
local currentBeardList = {}

if sex == 1 then
    for i,v in pairs(MaleComp) do
        table.insert(elements, {label = i, cat = "hair", value = i, desc = "Selecione o Cabelo e Depois a Coloração"})
    end
else
    for i,v in pairs(FemaleComp) do
        table.insert(elements, {label = i, cat = "hair", value = i, desc = "Selecione o Cabelo e Depois a Coloração"})
    end
end

MenuData.Open(
    'default', GetCurrentResourceName(), 'Cabeleireiro_Menu',
    {
        title    = 'Cabeleireiro',
        
        subtext    = 'Salão',

        align    = 'top-right',

        elements = elements,
    },
    function(data, menu)
        if sex == 1 then
            for i,v in pairs(MaleComp) do
                local estilocabelo = i
                if(data.current.value) == estilocabelo then
                    for _,b in pairs(v) do
                        menu.close()
                        table.insert(cabeleira, b.Hash)
                        barbamenu(estilocabelo)
                    end
                end
            end
        else
            for i,v in pairs(FemaleComp) do
                local estilocabelo = i
                if(data.current.value) == estilocabelo then
                    for _,b in pairs(v) do
                        menu.close()
                        table.insert(cabeleira, b.Hash)
                        barbamenu(estilocabelo)
                    end
                end
            end
        end
    end,
    
    function(data, menu)
        menu.close()
        cabeleireiro()
    end,
    function(data, menu)
        if sex == 1 then
            for i,v in pairs(MaleComp) do
                for _,b in pairs(v) do
                    if data.current.label == i then
                        local hash = ("0x" ..b.Hash)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- HAIR
                    end
                end
            end
        else
            for i,v in pairs(FemaleComp) do
                for _,b in pairs(v) do
                    if data.current.label == i then
                        local hash = ("0x" ..b.Hash)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- HAIR
                    end
                end
            end
        end
	end)  
end

function barba()
MenuData.CloseAll()
local myPed = PlayerPedId()
local sex = IsPedMale(myPed)
local elements = {}
local currentHairList = {}
local currentHairListWoman = {}
local currentBeardList = {}

if sex == 1 then
    for i,v in pairs(MaleCompBarba) do
        table.insert(elements, {label = i, cat = i, value = i, desc = "Selecione a Barba e Depois a Coloração"})
    end
end


MenuData.Open(
    'default', GetCurrentResourceName(), 'Cabeleireiro_Menu',
    {
        title    = 'Cabeleireiro',
        
        subtext    = 'Salão',

        align    = 'top-right',

        elements = elements,
    },
    function(data, menu)
        if sex == 1 then
            for i,v in pairs(MaleCompBarba) do
                local estilobarba = i
                if(data.current.value) == estilobarba then
                    for _,b in pairs(v) do
                        menu.close()
                        table.insert(barbas, b.Hash)
                        barbamenu(estilobarba)
                    end
                end
            end
        end
    end,
    
    function(data, menu)
        menu.close()
        cabeleireiro()
    end,
    function(data, menu)
        if sex == 1 then
            for i,v in pairs(MaleCompBarba) do
                for _,b in pairs(v) do
                    if data.current.label == i then
                        local hash = ("0x" ..b.Hash)
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- HAIR
                    end
                end
            end
        end
    end) 
end

-- Menu_base 
function barbamenu(estilocabelo)
    MenuData.CloseAll()
    local myPed = PlayerPedId()
    local sex = IsPedMale(myPed)
    local elements = {}
    local currentHairList = {}
    local currentHairListWoman = {}
    local currentBeardList = {}

    if sex == 1 then
        if fazendobarba == false then
            for i,v in pairs(MaleComp) do
                for _,b in pairs(v) do
                    if estilocabelo == b.name then
                        table.insert(elements, {label = b.color, cat = b.category, value = _, hash = b.value, desc = "Selecione o Cabelo"})
                        currentHairList = cabeleira
                    end
                end
            end
        else
            for i,v in pairs(MaleCompBarba) do
                for _,b in pairs(v) do
                    if estilocabelo == b.name then
                        table.insert(elements, {label = b.color, cat = b.category, value = _, hash = b.value, desc = "Selecione a Barba"})
                        currentBeardList = barbas
                    end
                end
            end
        end
    else
        for i,v in pairs(FemaleComp) do
            for _,b in pairs(v) do
                if estilocabelo == b.name then
                    table.insert(elements, {label = b.color, cat = b.category, value = _, hash = b.value, desc = "Selecione o Cabelo"})
                    currentHairListWoman = cabeleira
                end
            end
        end
    end
    
	MenuData.Open('default', GetCurrentResourceName(), 'barber_menu',{
		title    = "Barbearia",	
		subtext  = 'Selecione',
		align    = 'top-right',
		elements = elements,
	},
    function(data, menu)
        local elements2 = {}
        local OpenSub = false
        local title2 = ""
        local subtitle2 = ""
        local category = data.current.cat
        if category == 'hair' then
            title2 = "Cortar por $4?"
            subtitle2 = "Cabelo"
            elements2 = {
                {label = "Sim", value = 'yes'},
                {label = "Não", value = 'no'},
            }
            OpenSub = true
        elseif category == 'mustache' then
            title2 = "Cortar por $2?"
            subtitle2 = "Barba"
            elements2 = {
                {label = "Sim", value = 'yes'},
                {label = "Não", value = 'no'},
            }
            OpenSub = true
        end

        if OpenSub == true then
            OpenSub = false
            MenuData.Open('default', GetCurrentResourceName(), 'barber_'..category, {
                title = title2,
                subtext = subtitle2,
                align = 'top-right',
                elements = elements2,
            }, 
            function(data2, menu2)
                if data.current.cat == "hair" and data2.current.value == "yes" then
                    if selectedhairIndex == nil then                     
                        TriggerEvent('redem_roleplay:Tip', "Você Precisa Selecionar a Cor de Cabelo!", 4000)
                    else
                        TriggerServerEvent("vesgoboy_barber:SaveHair", selectedhairIndex)
                    end
                    cabeleireiro()
                    sentado = false       
                elseif data.current.cat == "mustache" and data2.current.value == "yes" then
                    if selectedhairIndex == nil then 
                        TriggerEvent('redem_roleplay:Tip', "Você Precisa Selecionar a Cor da Barba!", 4000)
                    else
                        TriggerServerEvent("vesgoboy_barber:SaveBeard", selectedmustacheIndex)
                    end
                    cabeleireiro()
                    sentado = false  
                elseif data2.current.value == "no" then
                    menu2.close()
                    sentado = false
                    cabeleireiro()
                end
            end, 
            function(data2, menu2)
                menu2.close()
                sentado = false
                cabeleireiro()
            end) 
        end
    end,
	function(data, menu)
		menu.close()
        cabeleireiro()
	end,
	function(data, menu)
        currenthairIndex = data.current.value
        selectedhairIndex = data.current.hash

        currentmustacheIndex = data.current.value
        selectedmustacheIndex = data.current.hash

        if data.current.cat == "hair" and sex == 1 then
            local hash = ("0x" ..currentHairList[data.current.value])
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- HAIR
        elseif data.current.cat == "hair" and sex == false then
            local hash = ("0x" ..currentHairListWoman[data.current.value])
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- HAIR
        elseif data.current.cat == "mustache" then
            local hash = ("0x" ..currentBeardList[data.current.value])
            Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),tonumber(hash),true,true,true) -- Facial hair
        end
	end)
end

--=================Prompt=================== OK
local CoolDown = 0
local OpenPrompt
local PromptGroup = GetRandomIntInRange(0, 0xffffff)

function SetupOpenPrompt()
    Citizen.CreateThread(function()
        local str = 'Barbearia'
        OpenPrompt = PromptRegisterBegin()
        PromptSetControlAction(OpenPrompt, 0xCEFD9220) -- E
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(OpenPrompt, str)
        PromptSetEnabled(OpenPrompt, 1)
        PromptSetVisible(OpenPrompt, 1)
		PromptSetHoldMode(OpenPrompt, 1)
		PromptSetGroup(OpenPrompt, PromptGroup)
		PromptRegisterEnd(OpenPrompt)
    end)
end
--=================Prompt=================== OK

Citizen.CreateThread(function()
    SetupOpenPrompt()
	while true do
        Citizen.Wait(1)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        
        for barbearia,cadeira in pairs(Config.Barbearias) do
            local barbearia = cadeira.cadeira
            local distanciabarber = GetDistanceBetweenCoords(coords, barbearia, true)

            if distanciabarber < 1.5 and sentado == false then
                local sentar = cadeira.sentar
                local label  = CreateVarString(10, 'LITERAL_STRING', "Sentar")
                PromptSetActiveGroupThisFrame(PromptGroup, label)
                if PromptHasHoldModeCompleted(OpenPrompt) and CoolDown < 1 then
                    if IsPedOnMount(PlayerPedId()) then
                        return false
                    end
                
                    if IsPedInAnyVehicle(PlayerPedId()) then
                        return false
                    end
                
                    if IsPedDeadOrDying(PlayerPedId()) then
                        return false
                    end
                
                    if IsEntityInWater(PlayerPedId()) then
                        return false
                    end
                
                    if IsPedClimbing(PlayerPedId()) then
                        return false
                    end
                
                    if not IsPedOnFoot(PlayerPedId()) then
                        return false
                    end
                
                    if IsPedSittingInAnyVehicle(PlayerPedId()) then
                        return false
                    end

                    sentado = true
                    TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey("PROP_PLAYER_BARBER_SEAT"), sentar, 0, true, 0)
                    Citizen.Wait(5000)
                    cabeleireiro()
                end
            end

        end
	end
end)