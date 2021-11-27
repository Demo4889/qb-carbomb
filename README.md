# qb-carbomb
An IED device used to blow up a car

This script was inspired by the RNG_CarBomb (https://github.com/Developer-Bear/RNG_CarBomb) script for ESX. Thanks to those guys for the building blocks of the script. All modifications to the script are made by myself for QBCore.

Make sure you include the item into your qb-core/shared.lua file

	['ied'] 				 		 = {['name'] = 'ied', 			  	  			['label'] = 'IED', 						['weight'] = 500, 		['type'] = 'item', 		['image'] = 'ied.png', 						['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Maybe I can blow something up with this...'},

After you have included the item, restart your server and run it. Let me know if you have any issues.

You can also used the ied.png file as your inventory image if you'd like. Or find one that suits the look you want
