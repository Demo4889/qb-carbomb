Config = {}

Config.Item = 'ied'
-- Detonation Types
-- 0 (Explode After Countdown)
-- 1 (Explode once the veh reaches a set speed)
-- 2 (Remote Detonate on Key Press)
-- 3 (Detonate after veh is entered and timer ends)
-- 4 (Detonate Immediately After the vehicle is entered)

Config.Detonation = {
    type = 1,
    arming = 5,
    detonation = math.random(3,10)
    speed = 50
}

Config.ArmingTime = math.random(5000, 10000)

Config.TriggerKey = 47 -- If using type 2

Config.Speed = 'MPH' -- if using type 2