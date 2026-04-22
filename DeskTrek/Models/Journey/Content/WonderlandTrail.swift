import Foundation

// MARK: - Wonderland Trail (93 miles, loops Mt. Rainier)

extension Trail {
    static let wonderland = Trail(
        id: "wonderland",
        name: "Wonderland Trail",
        subtitle: "Around Mt. Rainier",
        totalMiles: 93.0,
        landmarks: WonderlandContent.landmarks,
        encounters: WonderlandContent.encounters,
        subquests: WonderlandContent.subquests,
        badges: WonderlandContent.badges,
        mapArt: TrailMapArt(
            skyAsset: "parallax.wonder.sky",
            mountainAsset: "parallax.wonder.mountains",
            hillAsset: "parallax.wonder.hills",
            groundAsset: "parallax.wonder.ground"
        ),
        finaleArt: "finale.wonder",
        certificateCopy: "I walked the full circumference of Mt. Rainier from my desk and this certificate proves it."
    )
}

private enum WonderlandContent {

    // MARK: - Landmarks (8)

    static let landmarks: [Landmark] = [
        Landmark(
            id: "wonder.longmire",
            name: "Longmire",
            flavorText: "You step off the porch of the National Park Inn. The log buildings smell of woodsmoke and rain. Mile zero of the Wonderland.",
            spriteAsset: "landmark.wonder.longmire",
            mileMarker: 0.5,
            isMajor: true
        ),
        Landmark(
            id: "wonder.cougar_rock_bridge",
            name: "Tahoma Creek Bridge",
            flavorText: "A narrow suspension bridge sways over glacier meltwater the color of pale tea. You walk gently. The cables hum.",
            spriteAsset: "landmark.wonder.cougar_rock_bridge",
            mileMarker: 7.0,
            isMajor: false
        ),
        Landmark(
            id: "wonder.emerald_ridge",
            name: "Emerald Ridge",
            flavorText: "The Tahoma Glacier unfolds across the western face of Rainier, blue-white and immense. You sit. You do not immediately get up.",
            spriteAsset: "landmark.wonder.emerald_ridge",
            mileMarker: 22.0,
            isMajor: true
        ),
        Landmark(
            id: "wonder.klapatche_park",
            name: "Klapatche Park",
            flavorText: "Aurora Lake lies flat as glass. Rainier stands in the water, inverted and perfect. You photograph it, knowing no photo will work.",
            spriteAsset: "landmark.wonder.klapatche_park",
            mileMarker: 32.0,
            isMajor: false
        ),
        Landmark(
            id: "wonder.spray_park",
            name: "Spray Park",
            flavorText: "The meadow is on fire with wildflowers — lupine, paintbrush, avalanche lily. Marmots whistle warnings from every boulder.",
            spriteAsset: "landmark.wonder.spray_park",
            mileMarker: 48.0,
            isMajor: true
        ),
        Landmark(
            id: "wonder.mystic_lake",
            name: "Mystic Lake",
            flavorText: "An alpine tarn below Willis Wall. The north face of Rainier looms directly above — gray and terrifying in its nearness.",
            spriteAsset: "landmark.wonder.mystic_lake",
            mileMarker: 60.0,
            isMajor: false
        ),
        Landmark(
            id: "wonder.summerland",
            name: "Summerland",
            flavorText: "A subalpine bowl at the foot of the mountain's east face. The heather is purple. The sun is honey. You are closer to Rainier than you have ever been.",
            spriteAsset: "landmark.wonder.summerland",
            mileMarker: 75.0,
            isMajor: true
        ),
        Landmark(
            id: "wonder.panhandle_gap",
            name: "Panhandle Gap",
            flavorText: "At 6,750 feet, the highest point on the Wonderland. The trail drops back toward Longmire. You have circled a volcano. The loop is yours.",
            spriteAsset: "landmark.wonder.panhandle_gap",
            mileMarker: 92.5,
            isMajor: true
        )
    ]

    // MARK: - Badges (3 trail-specific)

    static let badges: [Badge] = [
        Badge(id: "wonder.volcano_circler",  name: "Volcano Circler",  description: "Completed a full circumnavigation of Mt. Rainier.", iconAsset: "badge.wonder.volcano_circler"),
        Badge(id: "wonder.rangers_friend",   name: "Ranger's Friend",  description: "Completed the 'Circumnavigation' subquest.",       iconAsset: "badge.wonder.rangers_friend"),
        Badge(id: "wonder.weather_eye",      name: "Weather Eye",      description: "Completed the 'Weather Eye' subquest.",            iconAsset: "badge.wonder.weather_eye")
    ]

    // MARK: - Subquests (2 × 3 stages)

    static let subquests: [Subquest] = [
        Subquest(
            id: "wonder.circumnavigation",
            title: "The Circumnavigation",
            description: "A retired ranger is walking the loop one last time. Your paths keep crossing.",
            stageEncounterIDs: ["wonder.ranger_1", "wonder.ranger_2", "wonder.ranger_3"],
            completionBadgeID: "wonder.rangers_friend"
        ),
        Subquest(
            id: "wonder.weather_eye",
            title: "Weather Eye",
            description: "The mountain makes its own weather. Three decisions, ascending in severity.",
            stageEncounterIDs: ["wonder.weather_1", "wonder.weather_2", "wonder.weather_3"],
            completionBadgeID: "wonder.weather_eye"
        )
    ]

    // MARK: - Encounters (~13)

    static let encounters: [EncounterEvent] = [
        // --- Standalone ---
        EncounterEvent(
            id: "wonder.glacier_ford",
            triggerMile: 10.0,
            title: "Tahoma Creek",
            body: "The creek is the color of milk — glacier rock flour. A footlog has slipped and lies half-submerged. Rocks across the ford would work if you're quick.",
            choices: [
                Choice(id: "rocks", label: "Rock-hop across", moraleDelta: 4, energyDelta: -4, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "You hop four stones, one foot splashing into icewater on the last. The bank is warm in the sun. You call that a win."),
                Choice(id: "log", label: "Crawl the half-sunk log", moraleDelta: 2, energyDelta: -2, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You inch across on hands and knees. The log is slick but holds. Your pants are wet at the calves and that is all.")
            ],
            defaultChoiceID: "log",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "wonder.mountain_goat",
            triggerMile: 20.0,
            title: "Mountain Goat on the Ledge",
            body: "A mountain goat stands on an impossibly narrow shelf above the trail, chewing nothing and watching you with yellow slit-eyes. A kid hides behind her.",
            choices: [
                Choice(id: "wait", label: "Wait for her to leave", moraleDelta: 5, energyDelta: 0, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You sit and drink water. Ten minutes later she moves on, delicate as a dancer. The kid follows. The trail is yours."),
                Choice(id: "detour", label: "Detour around on the talus", moraleDelta: 2, energyDelta: -3, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You scramble up through loose rock. By the time you rejoin the trail the goats are gone anyway.")
            ],
            defaultChoiceID: "wait",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "wonder.huckleberry",
            triggerMile: 35.0,
            title: "Huckleberry Patch",
            body: "A hillside of ripe huckleberries — dark and warm and the size of peas. You could spend an hour filling a bandana with them.",
            choices: [
                Choice(id: "pick", label: "Pick a pint", moraleDelta: 8, energyDelta: 3, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "Your fingers go purple. You eat most of what you pick. A black bear at the ridge top is doing the same thing, unbothered."),
                Choice(id: "press_on", label: "Eat a handful and move", moraleDelta: 3, energyDelta: 1, badgeAwarded: "ultralight", followupEncounterID: nil,
                       resultText: "Five minutes, one sweet mouthful, back on trail. You think about the berries for the next mile.")
            ],
            defaultChoiceID: "pick",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "wonder.steam_vent",
            triggerMile: 52.0,
            title: "Steam Vent",
            body: "A fissure beside the trail breathes warm air and smells faintly of sulfur. Rainier reminds you, politely, that it is a volcano.",
            choices: [
                Choice(id: "peer", label: "Kneel and look in", moraleDelta: 6, energyDelta: -1, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "Warm, damp, alive. You can feel the mountain's heartbeat. You sit there a long minute before moving on."),
                Choice(id: "skirt", label: "Give it a wide berth", moraleDelta: 2, energyDelta: 0, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You step around it. The ground feels solid. You prefer it that way.")
            ],
            defaultChoiceID: "peer",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "wonder.elk_herd",
            triggerMile: 58.0,
            title: "Elk at Dusk",
            body: "A bull elk and six cows graze in a meadow fifty yards off trail. The bull raises his antlered head. He has not decided whether you are a problem.",
            choices: [
                Choice(id: "freeze", label: "Stand still and watch", moraleDelta: 8, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You hold still for five minutes. The bull decides you are furniture and goes back to grass. You back away slowly when they're not looking."),
                Choice(id: "detour", label: "Circle wide through the trees", moraleDelta: 3, energyDelta: -2, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You duck into the hemlocks and take a long loop. The elk never see you. A fair trade.")
            ],
            defaultChoiceID: "freeze",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "wonder.old_growth",
            triggerMile: 65.0,
            title: "Old Growth",
            body: "You pass through a grove of Douglas firs older than the United States. One has a trunk wider than your apartment's bathroom. You feel small and fine about it.",
            choices: [
                Choice(id: "touch", label: "Put your hand on the bark", moraleDelta: 10, energyDelta: 1, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "The bark is rough and warm. Three hundred years of standing still. You feel calmer walking out than in."),
                Choice(id: "pass", label: "Walk through reverently", moraleDelta: 5, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You don't stop, but you walk slowly. The trees make the sound that only very large trees make.")
            ],
            defaultChoiceID: "touch",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "wonder.fog_whiteout",
            triggerMile: 82.0,
            title: "Whiteout",
            body: "Cloud swallows the ridge. Visibility collapses to ten feet. The cairns are your only map now, one stone-stack every hundred yards.",
            choices: [
                Choice(id: "cairn", label: "Follow cairns carefully", moraleDelta: 4, energyDelta: -5, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "Cairn to cairn, hand on compass. Twenty minutes later the fog thins. The trail is exactly where it should be."),
                Choice(id: "push", label: "Trust the trail and push on", moraleDelta: 6, energyDelta: -8, badgeAwarded: "storm_chaser", followupEncounterID: nil,
                       resultText: "You walk straight through grey. The world re-emerges at the other edge. You are pleased with yourself and a little adrenaline-sick.")
            ],
            defaultChoiceID: "cairn",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),

        // --- Circumnavigation subquest (3 stages) ---
        EncounterEvent(
            id: "wonder.ranger_1",
            triggerMile: 5.0,
            title: "The Retired Ranger",
            body: "An older man with a sun-dark face and a small pack sits on the bench at Cougar Rock. 'One last loop,' he says, half to himself. He is walking Wonderland for the fortieth time.",
            choices: [
                Choice(id: "ask", label: "Ask for his stories", moraleDelta: 6, energyDelta: -1, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "He tells you about a ranger cabin in the '70s and the time a black bear opened a tin of sardines. You could listen all afternoon."),
                Choice(id: "nod", label: "Nod and keep walking", moraleDelta: 1, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You wave. He waves. You wonder, a mile later, what he would have said.")
            ],
            defaultChoiceID: "ask",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "wonder.circumnavigation"
        ),
        EncounterEvent(
            id: "wonder.ranger_2",
            triggerMile: 40.0,
            title: "Aurora Lake, Again",
            body: "The retired ranger is already at Klapatche, boiling water for tea on a tiny stove. 'You caught me,' he says. 'I'm slow these days.' He offers you a cup.",
            choices: [
                Choice(id: "tea", label: "Accept the tea", moraleDelta: 10, energyDelta: 3, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "It's bitter and hot and exactly what you wanted. He tells you about his daughter who hikes the PCT. You sit by the lake for twenty minutes."),
                Choice(id: "wave_on", label: "Wave and press on", moraleDelta: 4, energyDelta: 0, badgeAwarded: "ultralight", followupEncounterID: nil,
                       resultText: "You keep moving. The smell of tea stays with you up the next climb.")
            ],
            defaultChoiceID: "tea",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "wonder.circumnavigation"
        ),
        EncounterEvent(
            id: "wonder.ranger_3",
            triggerMile: 90.0,
            title: "At the Gap",
            body: "The old ranger is sitting on a rock at Panhandle Gap, watching the mountain the way a person watches an old friend. He sees you and lifts a hand.",
            choices: [
                Choice(id: "sit", label: "Sit with him a while", moraleDelta: 12, energyDelta: 2, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You sit. Neither of you says much. Rainier does most of the talking. When you stand to go, he says, 'Thanks for the company,' and means it."),
                Choice(id: "finish", label: "Finish the loop together", moraleDelta: 15, energyDelta: 0, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "You walk the last stretch side by side, slow and not talking. At Longmire he shakes your hand. 'See you on another one,' he says, and you believe him.")
            ],
            defaultChoiceID: "sit",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "wonder.circumnavigation"
        ),

        // --- Weather Eye subquest (3 stages) ---
        EncounterEvent(
            id: "wonder.weather_1",
            triggerMile: 15.0,
            title: "Lenticular",
            body: "A disc-shaped lenticular cloud caps Rainier's summit — the classic sign of moisture and wind aloft. The old rangers read them like tea leaves.",
            choices: [
                Choice(id: "note", label: "Note it and plan low camp", moraleDelta: 3, energyDelta: 2, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You mark it in your journal. Tonight you camp in the trees. Tomorrow the sky confirms you were right."),
                Choice(id: "ignore", label: "Pretty cloud. Keep walking.", moraleDelta: 1, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You walk on. An hour later the wind picks up. You think of the cloud.")
            ],
            defaultChoiceID: "note",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "wonder.weather_eye"
        ),
        EncounterEvent(
            id: "wonder.weather_2",
            triggerMile: 38.0,
            title: "Afternoon Squall",
            body: "Wind shifts. The temperature drops ten degrees in two minutes. The hillside above is still sunny but the cloud arriving from the west is dark and low.",
            choices: [
                Choice(id: "layer", label: "Layer up and drop to treeline", moraleDelta: 4, energyDelta: -3, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You hear the squall arrive while you're zipping your rain shell. By the time it settles you're warm, dry, and eating a bar under a fir."),
                Choice(id: "outrun", label: "Try to make the next shelter", moraleDelta: 6, energyDelta: -8, badgeAwarded: "storm_chaser", followupEncounterID: nil,
                       resultText: "You run. You lose. The squall hits with rain going sideways. You arrive at the shelter soaked and laughing.")
            ],
            defaultChoiceID: "layer",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "wonder.weather_eye"
        ),
        EncounterEvent(
            id: "wonder.weather_3",
            triggerMile: 70.0,
            title: "Lightning on the Ridge",
            body: "Thunder rolls up the valley — three seconds from flash to boom, closing fast. You are on an exposed ridge with nowhere great to go. A shallow basin 400 feet below looks safer.",
            choices: [
                Choice(id: "descend", label: "Drop off the ridge immediately", moraleDelta: 5, energyDelta: -6, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You scramble down on your heels. Hailstones the size of peas hit you halfway. In the basin you crouch, pack off, and wait. Nothing strikes near you."),
                Choice(id: "sprint", label: "Sprint for the next col", moraleDelta: 3, energyDelta: -12, badgeAwarded: "storm_chaser", followupEncounterID: nil,
                       resultText: "You run with the storm chasing you. A bolt cracks somewhere behind. You reach the col alive and shaking. You sit for a long time.")
            ],
            defaultChoiceID: "descend",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "wonder.weather_eye"
        )
    ]
}
