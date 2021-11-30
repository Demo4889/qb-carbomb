Config = {}

Config.Item = 'ied'
-- Detonation Types
-- 1 (Explode After Countdown)
-- 2 (Explode once the veh reaches a set speed)
-- 3 (Remote Detonate on Key Press)
-- 4 (Detonate after veh is entered and timer ends)
-- 5 (Detonate Immediately After the vehicle is entered)
Config.DetonationType = 3

Config.PoliceJob = 'police'

Config.JobDisarm = true -- True for police only to disarm/False for everyone to disarm
Config.JobInspect = true -- True for police only to inspect/False for everyone to inspect

Config.TimeToArm = math.random(5000, 10000)

Config.Detonation = {
    [1] = {
        detonation = math.random(10, 20), -- can be math.random or a set amount
    },
    [2] = {
        display = "mph", -- set to mph or kmh
        speed = 50 -- set a speed at which the vehicle will explode
    },
    [3] = {
        key = 47, -- Key is G, change in the notification on line 41 of client
    },
    [4] = {
        detonation = math.random(3,10), -- can be math random or a set amount
    },
    [5] = {
        
    },
}