import Foundation

// MARK: - Superior Hiking Trail (310 miles, Jay Cooke to Grand Portage, MN)

extension Trail {
    static let superiorHiking = Trail(
        id: "sht",
        name: "Superior Hiking Trail",
        subtitle: "Jay Cooke to Grand Portage",
        totalMiles: 310.0,
        landmarks: SHTContent.landmarks,
        encounters: SHTContent.encounters,
        subquests: SHTContent.subquests,
        badges: SHTContent.badges,
        mapArt: TrailMapArt(
            skyAsset: "parallax.sht.sky",
            mountainAsset: "parallax.sht.mountains",
            hillAsset: "parallax.sht.hills",
            groundAsset: "parallax.sht.ground"
        ),
        finaleArt: "finale.sht",
        certificateCopy: "I walked the Superior Hiking Trail's full north-shore length from my desk and this certificate proves it."
    )
}

private enum SHTContent {

    // MARK: - Landmarks (10)

    static let landmarks: [Landmark] = [
        Landmark(
            id: "sht.jay_cooke",
            name: "Jay Cooke State Park",
            flavorText: "The St. Louis River roars through red slate below you. A swinging footbridge sways in the spray. Mile one, and already the trail means business.",
            spriteAsset: "landmark.sht.jay_cooke",
            mileMarker: 1.0,
            isMajor: true
        ),
        Landmark(
            id: "sht.enger_park",
            name: "Enger Park",
            flavorText: "Duluth unfolds below — the Aerial Lift Bridge, the long ore docks, a laker steaming under. Lake Superior stretches east until it becomes the sky.",
            spriteAsset: "landmark.sht.enger_park",
            mileMarker: 30.0,
            isMajor: false
        ),
        Landmark(
            id: "sht.gooseberry_falls",
            name: "Gooseberry Falls",
            flavorText: "Three tiers of black basalt, tea-colored water thundering over each. Mist cools your face. You stand on the overlook longer than you meant to.",
            spriteAsset: "landmark.sht.gooseberry_falls",
            mileMarker: 75.0,
            isMajor: true
        ),
        Landmark(
            id: "sht.split_rock_lighthouse",
            name: "Split Rock Lighthouse",
            flavorText: "The lighthouse sits on a 130-foot cliff over Superior, built after the great storm of 1905 wrecked twenty-nine ships in a single night. The beam still turns.",
            spriteAsset: "landmark.sht.split_rock_lighthouse",
            mileMarker: 95.0,
            isMajor: true
        ),
        Landmark(
            id: "sht.palisade_head",
            name: "Palisade Head",
            flavorText: "Sheer basalt cliffs drop 200 feet straight into Lake Superior. You lie on your belly at the edge. The water is impossibly clear and impossibly cold.",
            spriteAsset: "landmark.sht.palisade_head",
            mileMarker: 115.0,
            isMajor: false
        ),
        Landmark(
            id: "sht.temperance_river",
            name: "Temperance River Gorge",
            flavorText: "The river has carved a slot through solid basalt — black walls, white water, potholes the size of cars scoured into the rock. You walk the rim, dizzy.",
            spriteAsset: "landmark.sht.temperance_river",
            mileMarker: 150.0,
            isMajor: false
        ),
        Landmark(
            id: "sht.carlton_peak",
            name: "Carlton Peak",
            flavorText: "The summit is a tumble of anorthosite boulders. You scramble to the top. The horizon is lake in three directions and forest in one.",
            spriteAsset: "landmark.sht.carlton_peak",
            mileMarker: 175.0,
            isMajor: true
        ),
        Landmark(
            id: "sht.bean_bear_lakes",
            name: "Bean & Bear Lakes",
            flavorText: "Two kidney-shaped lakes lie nested in green ridges below the overlook. A loon calls from Bean Lake. Another answers from somewhere behind Bear.",
            spriteAsset: "landmark.sht.bean_bear_lakes",
            mileMarker: 220.0,
            isMajor: false
        ),
        Landmark(
            id: "sht.caribou_falls",
            name: "Caribou Falls",
            flavorText: "The Caribou River slides over a ledge and disappears into Lake Superior fifty yards later. A merganser shepherds her ducklings through the pool at your feet.",
            spriteAsset: "landmark.sht.caribou_falls",
            mileMarker: 255.0,
            isMajor: false
        ),
        Landmark(
            id: "sht.grand_portage",
            name: "Grand Portage",
            flavorText: "The northern terminus. Canada is a green line across the water. The last blue blaze is behind you. Three hundred and ten miles of lakeshore and ridge.",
            spriteAsset: "landmark.sht.grand_portage",
            mileMarker: 310.0,
            isMajor: true
        )
    ]

    // MARK: - Badges (4 trail-specific)

    static let badges: [Badge] = [
        Badge(id: "sht.gitchi_gumi_walker",     name: "Gitchi-Gumi Walker",    description: "Walked the full length of Lake Superior's north shore.", iconAsset: "badge.sht.gitchi_gumi_walker"),
        Badge(id: "sht.lighthouse_friend",      name: "Lightkeeper's Friend",  description: "Completed the 'Lightkeeper's Ghost' subquest.",          iconAsset: "badge.sht.lighthouse_friend"),
        Badge(id: "sht.moose_tracker",          name: "Moose Tracker",         description: "Completed the 'Moose Country' subquest.",                iconAsset: "badge.sht.moose_tracker"),
        Badge(id: "sht.north_shore_chronicler", name: "North Shore Chronicler", description: "Completed the 'Driftwood Journal' subquest.",            iconAsset: "badge.sht.north_shore_chronicler")
    ]

    // MARK: - Subquests (3 × 3 stages)

    static let subquests: [Subquest] = [
        Subquest(
            id: "sht.lighthouse_keeper",
            title: "The Lightkeeper's Ghost",
            description: "The last keeper of Split Rock has a descendant walking the trail.",
            stageEncounterIDs: ["sht.lightkeeper_1", "sht.lightkeeper_2", "sht.lightkeeper_3"],
            completionBadgeID: "sht.lighthouse_friend"
        ),
        Subquest(
            id: "sht.moose_country",
            title: "Moose Country",
            description: "A DNR biologist is tracking a cow moose and her calf northward.",
            stageEncounterIDs: ["sht.moose_1", "sht.moose_2", "sht.moose_3"],
            completionBadgeID: "sht.moose_tracker"
        ),
        Subquest(
            id: "sht.driftwood_journal",
            title: "The Driftwood Journal",
            description: "A log of lake storms, left in a shelter, asks the next hiker to continue it.",
            stageEncounterIDs: ["sht.journal_1", "sht.journal_2", "sht.journal_3"],
            completionBadgeID: "sht.north_shore_chronicler"
        )
    ]

    // MARK: - Encounters (~19)

    static let encounters: [EncounterEvent] = [
        // --- Standalone ---
        EncounterEvent(
            id: "sht.lake_effect_fog",
            triggerMile: 18.0,
            title: "Lake-Effect Fog",
            body: "Fog rolls off Superior in a low white wall and pours up through the ravines. The trail ahead vanishes. Cold damp air smells like wet stone.",
            choices: [
                Choice(id: "wait", label: "Wait it out on a ledge", moraleDelta: 3, energyDelta: 3, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You eat a bar, watch the fog shift through the trees, and in forty minutes it burns off. The lake emerges below, impossibly blue."),
                Choice(id: "walk", label: "Walk through by feel", moraleDelta: 5, energyDelta: -3, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "The world shrinks to your boots and the blue blazes. A ghostly hiker passes the other way. Neither of you speaks.")
            ],
            defaultChoiceID: "wait",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "sht.blueberries",
            triggerMile: 45.0,
            title: "A Blueberry Burn",
            body: "A decade-old burn has come back as blueberries — waist-high bushes, ripe fruit, open sky. A stand of new birches grows at the edge.",
            choices: [
                Choice(id: "graze", label: "Graze as you walk", moraleDelta: 8, energyDelta: 3, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You walk and eat for twenty minutes. Your tongue is blue. The burn smells of hot earth and resin and summer."),
                Choice(id: "pass", label: "Move through, don't stop", moraleDelta: 2, energyDelta: 1, badgeAwarded: "ultralight", followupEncounterID: nil,
                       resultText: "One handful, walking. Sweet and sun-warm. You resist grazing and make time.")
            ],
            defaultChoiceID: "graze",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "sht.wolf_tracks",
            triggerMile: 62.0,
            title: "Wolf Tracks",
            body: "Fresh tracks in soft mud — four toes and a heel-pad, bigger than your palm. They follow the trail for a hundred yards, then veer into the spruce.",
            choices: [
                Choice(id: "follow", label: "Follow a few steps off-trail", moraleDelta: 7, energyDelta: -2, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "You step into the spruce. Silence. The tracks fade into duff. You never see the wolf. You know the wolf saw you."),
                Choice(id: "note", label: "Photograph and press on", moraleDelta: 4, energyDelta: 0, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You take the picture. The track is beautiful. You walk the next mile very aware of every small sound.")
            ],
            defaultChoiceID: "note",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "sht.bog_boardwalk",
            triggerMile: 110.0,
            title: "The Sphagnum Bog",
            body: "A plank boardwalk crosses a quaking bog — cedars dead and leaning, tamaracks gold, pitcher plants underfoot. Some planks are rotted. Some are missing.",
            choices: [
                Choice(id: "careful", label: "Pick each plank carefully", moraleDelta: 3, energyDelta: -2, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You test each board with a foot. One gives slightly but holds. You cross clean. The bog smells like tea and time."),
                Choice(id: "bound", label: "Move fast, long strides", moraleDelta: 5, energyDelta: -4, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "You skip every third plank. One rotted board cracks behind you. You reach solid ground in ninety seconds, laughing.")
            ],
            defaultChoiceID: "careful",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "sht.loon_call",
            triggerMile: 130.0,
            title: "Loon at Dusk",
            body: "You make camp on a small lake. As the light goes orange, a loon surfaces in the middle of the water and sings — that long, lost, uncanny cry.",
            choices: [
                Choice(id: "listen", label: "Sit on the shore and listen", moraleDelta: 12, energyDelta: 2, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You sit an hour. The loon sings seven times. A second loon answers from across the water. You sleep easy."),
                Choice(id: "supper", label: "Make supper — listen while cooking", moraleDelta: 5, energyDelta: 1, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "Your stew is the same stew but it tastes better with a loon calling. You fall asleep with the bird still out there.")
            ],
            defaultChoiceID: "listen",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "sht.ore_freighter",
            triggerMile: 160.0,
            title: "An Ore Freighter",
            body: "From a high cliff, you watch a thousand-foot laker steam east toward the Soo. The hull is red with iron ore dust. A white plume of gulls follows it.",
            choices: [
                Choice(id: "watch", label: "Watch it pass", moraleDelta: 7, energyDelta: 1, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "The ship takes twenty minutes to cross your view. You think about the men on it, steering a city. You wave. You cannot tell if anyone waves back."),
                Choice(id: "wave_go", label: "Wave and walk on", moraleDelta: 3, energyDelta: 0, badgeAwarded: "ultralight", followupEncounterID: nil,
                       resultText: "A two-second wave from the cliff edge. You move on. You hear the freighter's horn ten minutes later, and smile.")
            ],
            defaultChoiceID: "watch",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "sht.black_flies",
            triggerMile: 195.0,
            title: "Black Fly Hatch",
            body: "A cloud of black flies has materialized over a creek crossing. They do not want your blood. They want your eyes, your ears, your nose, and your sanity.",
            choices: [
                Choice(id: "headnet", label: "Stop and put on a headnet", moraleDelta: 2, energyDelta: -1, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "Thirty seconds of zipping and adjusting. The flies continue to hate you but cannot land. You cross in peace."),
                Choice(id: "sprint", label: "Run for it", moraleDelta: -2, energyDelta: -4, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "You sprint eighty yards. You swallow at least one fly. You reach clear air filthy and victorious.")
            ],
            defaultChoiceID: "headnet",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "sht.aurora",
            triggerMile: 240.0,
            title: "Aurora",
            body: "You wake at two in the morning because the sky is wrong. You unzip the tent. Green curtains ripple across the north. You forget the cold.",
            choices: [
                Choice(id: "watch", label: "Watch until you can't stand", moraleDelta: 15, energyDelta: -3, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You stand in a puffy and long johns for forty minutes, shivering and grinning. The green turns pink. You sleep at dawn, dazed and changed."),
                Choice(id: "sleep", label: "Log it and go back to sleep", moraleDelta: 6, energyDelta: 4, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You watch for ten minutes, wake your trail partner for a glimpse, zip up, and sleep. The dream is also green.")
            ],
            defaultChoiceID: "watch",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "sht.beaver_dam",
            triggerMile: 268.0,
            title: "Beaver Engineering",
            body: "A fresh beaver dam has flooded fifty yards of trail ankle-deep. The beaver is on the dam, watching you with obvious opinions. A log detour is possible upstream.",
            choices: [
                Choice(id: "wade", label: "Wade through", moraleDelta: 4, energyDelta: -4, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "Cold water to the knee. The beaver slaps his tail in protest. You emerge on the far side with wet boots and respect."),
                Choice(id: "log", label: "Detour over the logs", moraleDelta: 3, energyDelta: -2, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You pick across the crown of the dam itself. The beaver dives. You're walking on his house. You keep your feet.")
            ],
            defaultChoiceID: "log",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "sht.shipwreck_cairn",
            triggerMile: 292.0,
            title: "Shipwreck Cairn",
            body: "A stone cairn on a point — three feet tall, weathered smooth. A hand-painted board reads: 'SS ONOKO, 1915, SIX HANDS LOST.' The lake below is calm today.",
            choices: [
                Choice(id: "stone", label: "Add a stone to the cairn", moraleDelta: 6, energyDelta: 0, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "You find a flat gray stone and place it. A gesture to six men you will never know. The lake keeps its silence."),
                Choice(id: "pause", label: "Stand a moment, then walk", moraleDelta: 4, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You bow your head. The wind moves in the pines. You walk on thoughtful and slower than before.")
            ],
            defaultChoiceID: "stone",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),

        // --- Lightkeeper subquest ---
        EncounterEvent(
            id: "sht.lightkeeper_1",
            triggerMile: 95.5,
            title: "The Keeper's Granddaughter",
            body: "A woman with a field notebook is sketching the lighthouse from the cliff. She introduces herself. Her grandfather was Split Rock's last resident keeper. She's walking the trail her grandfather loved.",
            choices: [
                Choice(id: "listen", label: "Ask about the 1940 storm", moraleDelta: 7, energyDelta: -1, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "She tells you about the Armistice Day blizzard — eight foot drifts against the tower, three ships heard calling on the horn. Her grandfather stayed in the lamp room sixty hours."),
                Choice(id: "nod", label: "Wish her well and go", moraleDelta: 2, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "She nods. 'Enjoy the lake,' she says. You wonder what she's about to write down.")
            ],
            defaultChoiceID: "listen",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "sht.lighthouse_keeper"
        ),
        EncounterEvent(
            id: "sht.lightkeeper_2",
            triggerMile: 175.5,
            title: "A Photograph at Carlton",
            body: "On the summit of Carlton Peak, the same woman is already sitting on the rocks with a black-and-white photo in a plastic sleeve. It's her grandfather, young, at this exact spot in 1952.",
            choices: [
                Choice(id: "photo", label: "Take her photo in the same pose", moraleDelta: 10, energyDelta: 0, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "She stands where he stood. You frame it. She cries a little, laughs, and thanks you. She sends you the print by mail months later."),
                Choice(id: "share", label: "Trade trail stories", moraleDelta: 6, energyDelta: -1, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You sit and talk for half an hour about lighthouses, weather, her grandfather's temper. The wind is honest.")
            ],
            defaultChoiceID: "photo",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "sht.lighthouse_keeper"
        ),
        EncounterEvent(
            id: "sht.lightkeeper_3",
            triggerMile: 305.0,
            title: "At the Northern Light",
            body: "At the final overlook before Grand Portage, she is there — finishing where she started. She hands you an envelope. 'Open it at the terminus,' she says.",
            choices: [
                Choice(id: "walk", label: "Walk the last five miles together", moraleDelta: 15, energyDelta: 0, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "You finish together. The envelope holds her grandfather's last logbook entry from 1969 — copied out for you. You do not say much. Nothing needs saying."),
                Choice(id: "accept", label: "Accept it and press on alone", moraleDelta: 8, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You carry the envelope the last miles. At the terminus you open it — a logbook copy, a pressed thimbleberry leaf. You keep it.")
            ],
            defaultChoiceID: "walk",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "sht.lighthouse_keeper"
        ),

        // --- Moose Country subquest ---
        EncounterEvent(
            id: "sht.moose_1",
            triggerMile: 80.0,
            title: "A Radio-Collared Trail",
            body: "A woman in DNR uniform kneels beside a hoof-print in soft earth. A radio receiver clicks in her hand. 'Cow and calf, moving north. I'm trying to stay a day behind them.'",
            choices: [
                Choice(id: "help", label: "Offer to report sightings ahead", moraleDelta: 4, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "She gives you her sat-phone number and a laminated photo of the collared cow. 'Flick me a pin if you see her.' You tuck it into your chest strap."),
                Choice(id: "wish", label: "Wish her luck and go", moraleDelta: 1, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You nod and move on. The prints stay ahead of you for two miles, then turn into the willows.")
            ],
            defaultChoiceID: "help",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "sht.moose_country"
        ),
        EncounterEvent(
            id: "sht.moose_2",
            triggerMile: 168.0,
            title: "The Cow and Calf",
            body: "In a boggy meadow you see them — an enormous cow moose waist-deep in water, yanking up lily roots, the calf watching from the bank. The collar is clearly visible.",
            choices: [
                Choice(id: "pin", label: "Freeze, photograph, send pin", moraleDelta: 10, energyDelta: 0, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "You crouch, zoom, snap. GPS pin sent. The cow looks up — not at you, at something farther — then goes back to the roots. You back away invisible."),
                Choice(id: "closer", label: "Try to get closer", moraleDelta: -4, energyDelta: -6, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "The cow lifts her head. Ears flatten. You remember that a moose has killed more people than most bears and retreat fast. The calf bolts. You feel dumb.")
            ],
            defaultChoiceID: "pin",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "sht.moose_country"
        ),
        EncounterEvent(
            id: "sht.moose_3",
            triggerMile: 260.0,
            title: "Reunion at the Cascade",
            body: "At a shelter on Cascade River, the biologist is there — tent up, stove hissing. 'You saw them,' she says. 'Thank you. We have her tracked into protected country.' She pours you coffee.",
            choices: [
                Choice(id: "coffee", label: "Take the coffee", moraleDelta: 12, energyDelta: 4, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "The coffee is gritty and hot and perfect. She shows you a map dotted with sightings — yours is the best one. The calf has a chance now."),
                Choice(id: "brief", label: "Brief and keep moving", moraleDelta: 5, energyDelta: 0, badgeAwarded: "ultralight", followupEncounterID: nil,
                       resultText: "You shake her hand and press on. Miles later you think about the calf and hope.")
            ],
            defaultChoiceID: "coffee",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "sht.moose_country"
        ),

        // --- Driftwood Journal subquest ---
        EncounterEvent(
            id: "sht.journal_1",
            triggerMile: 55.0,
            title: "A Waterlogged Notebook",
            body: "In the corner of a lakeside shelter, wrapped in plastic, a battered spiral notebook. The cover reads: 'STORMS OF THE NORTH SHORE — add yours.' Entries date back fifteen years.",
            choices: [
                Choice(id: "write", label: "Take it, write a storm entry", moraleDelta: 7, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You remember a squall two nights back and write a page. Tell the wind. Tell the rain. Tell the lake noise at three in the morning. You wrap it carefully and pack it out."),
                Choice(id: "leave", label: "Leave it for the next hiker", moraleDelta: 0, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You set it back on the shelf. Someone will find it. Someone always does.")
            ],
            defaultChoiceID: "write",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "sht.driftwood_journal"
        ),
        EncounterEvent(
            id: "sht.journal_2",
            triggerMile: 180.0,
            title: "A Storm to Write About",
            body: "A real northeaster rolls in off Superior. Forty-knot winds, horizontal rain, hail at the edges. You make shelter behind a rock wall and ride it out for three hours.",
            choices: [
                Choice(id: "write_now", label: "Write while it's happening", moraleDelta: 10, energyDelta: -2, badgeAwarded: "storm_chaser", followupEncounterID: nil,
                       resultText: "You scribble on your knee in a plastic sleeve. The page smudges. The ink lives through the storm. The entry is alive in a way finished ones never are."),
                Choice(id: "after", label: "Wait, then write after", moraleDelta: 5, energyDelta: 1, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You wait it out dry. In the calm after, you write two pages about the sound. The lake has gone milk-white.")
            ],
            defaultChoiceID: "write_now",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "sht.driftwood_journal"
        ),
        EncounterEvent(
            id: "sht.journal_3",
            triggerMile: 308.0,
            title: "At Grand Portage",
            body: "At the terminus shelter, you find another weatherproof box. Inside: pens, a candle, and the beginning of a second volume. You add your storm pages. You sign the last line.",
            choices: [
                Choice(id: "sign", label: "Sign and close it", moraleDelta: 15, energyDelta: 0, badgeAwarded: "sht.north_shore_chronicler", followupEncounterID: nil,
                       resultText: "You sign the date, your trail name, and one line about what the lake gave you. The next hiker will carry it on. That is how it works."),
                Choice(id: "pocket", label: "Keep it — you earned it", moraleDelta: -4, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You carry it out. Halfway to the trailhead it feels wrong. You turn back and return it. Some things were meant to stay moving.")
            ],
            defaultChoiceID: "sign",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "sht.driftwood_journal"
        )
    ]
}
