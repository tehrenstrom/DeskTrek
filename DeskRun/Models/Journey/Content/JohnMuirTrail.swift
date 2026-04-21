import Foundation

// MARK: - John Muir Trail (211 miles, Yosemite Valley to Mt. Whitney)

extension Trail {
    static let johnMuir = Trail(
        id: "jmt",
        name: "John Muir Trail",
        subtitle: "Yosemite Valley to Mt. Whitney",
        totalMiles: 211.0,
        landmarks: JMTContent.landmarks,
        encounters: JMTContent.encounters,
        subquests: JMTContent.subquests,
        badges: JMTContent.badges,
        mapArt: TrailMapArt(
            skyAsset: "parallax.jmt.sky",
            mountainAsset: "parallax.jmt.mountains",
            hillAsset: "parallax.jmt.hills",
            groundAsset: "parallax.jmt.ground"
        ),
        finaleArt: "finale.jmt",
        certificateCopy: "I walked the length of the John Muir Trail from my desk and this certificate proves it."
    )
}

// Namespaced content to keep the top-level `Trail.johnMuir` readable.
private enum JMTContent {

    // MARK: - Landmarks (8)

    static let landmarks: [Landmark] = [
        Landmark(
            id: "jmt.happy_isles",
            name: "Happy Isles",
            flavorText: "You cross the footbridge at Happy Isles. Yosemite Valley spreads behind you — the true mile zero of the JMT.",
            spriteAsset: "landmark.jmt.happy_isles",
            mileMarker: 0.5,
            isMajor: true
        ),
        Landmark(
            id: "jmt.half_dome",
            name: "Half Dome",
            flavorText: "The granite face of Half Dome rises like a stone cathedral. You pause to watch the afternoon light bend over its shoulder.",
            spriteAsset: "landmark.jmt.half_dome",
            mileMarker: 16.6,
            isMajor: true
        ),
        Landmark(
            id: "jmt.cathedral_peak",
            name: "Cathedral Peak",
            flavorText: "Cathedral Peak's twin spires pierce the sky. Muir himself called this the most beautiful place on earth.",
            spriteAsset: "landmark.jmt.cathedral_peak",
            mileMarker: 33.1,
            isMajor: false
        ),
        Landmark(
            id: "jmt.tuolumne_meadows",
            name: "Tuolumne Meadows",
            flavorText: "The high meadow unfolds green and wide. Lyell Fork winds silver through the grass. You resupply and press south.",
            spriteAsset: "landmark.jmt.tuolumne_meadows",
            mileMarker: 39.5,
            isMajor: true
        ),
        Landmark(
            id: "jmt.thousand_island_lake",
            name: "Thousand Island Lake",
            flavorText: "Banner Peak mirrors in water scattered with tiny islands of stone. The trail turns east toward the Sierra crest.",
            spriteAsset: "landmark.jmt.thousand_island_lake",
            mileMarker: 60.8,
            isMajor: false
        ),
        Landmark(
            id: "jmt.muir_pass",
            name: "Muir Pass",
            flavorText: "The stone hut at Muir Pass shelters you from thinning air. You are higher than most of California now, alone under glacier-white light.",
            spriteAsset: "landmark.jmt.muir_pass",
            mileMarker: 116.0,
            isMajor: true
        ),
        Landmark(
            id: "jmt.forester_pass",
            name: "Forester Pass",
            flavorText: "At 13,153 feet, Forester is the highest point on the PCT and the gateway to the JMT's final stretch. Breath comes thin. The ridge runs sharp like a sword's edge.",
            spriteAsset: "landmark.jmt.forester_pass",
            mileMarker: 180.0,
            isMajor: true
        ),
        Landmark(
            id: "jmt.mt_whitney",
            name: "Mt. Whitney Summit",
            flavorText: "The tallest point in the lower 48 stands under your boots. The stone hut. The wind. The whole world below. You did this.",
            spriteAsset: "landmark.jmt.mt_whitney",
            mileMarker: 211.0,
            isMajor: true
        )
    ]

    // MARK: - Badges

    static let badges: [Badge] = [
        Badge(id: "cautious_hiker", name: "Cautious Hiker", description: "Chose the safe path more often than not.", iconAsset: "badge.cautious_hiker"),
        Badge(id: "trailblazer", name: "Trailblazer", description: "Took risks when the trail offered them.", iconAsset: "badge.trailblazer"),
        Badge(id: "good_samaritan", name: "Good Samaritan", description: "Helped fellow hikers along the way.", iconAsset: "badge.good_samaritan"),
        Badge(id: "storm_chaser", name: "Storm Chaser", description: "Walked through weather the sensible would not.", iconAsset: "badge.storm_chaser"),
        Badge(id: "peak_bagger", name: "Peak Bagger", description: "Visited every major landmark on the trail.", iconAsset: "badge.peak_bagger"),
        Badge(id: "ultralight", name: "Ultralight", description: "Kept your pack — and your mind — light.", iconAsset: "badge.ultralight"),
        Badge(id: "lost_hiker_saved", name: "Lost and Found", description: "Completed the 'Lost Hiker' subquest.", iconAsset: "badge.lost_hiker_saved"),
        Badge(id: "bear_canister_master", name: "Canister Master", description: "Completed the 'Bear Country' subquest.", iconAsset: "badge.bear_canister_master"),
        Badge(id: "sierra_storyteller", name: "Sierra Storyteller", description: "Completed the 'Trail Journal' subquest.", iconAsset: "badge.sierra_storyteller")
    ]

    // MARK: - Subquests (3, each 3 stages)

    static let subquests: [Subquest] = [
        Subquest(
            id: "lost_hiker",
            title: "The Lost Hiker",
            description: "Help a disoriented hiker find their way back.",
            stageEncounterIDs: ["jmt.lost_hiker_1", "jmt.lost_hiker_2", "jmt.lost_hiker_3"],
            completionBadgeID: "lost_hiker_saved"
        ),
        Subquest(
            id: "bear_country",
            title: "Bear Country",
            description: "A black bear has been visiting camps along the trail.",
            stageEncounterIDs: ["jmt.bear_country_1", "jmt.bear_country_2", "jmt.bear_country_3"],
            completionBadgeID: "bear_canister_master"
        ),
        Subquest(
            id: "trail_journal",
            title: "The Trail Journal",
            description: "A battered notebook left at a shelter begs to be finished.",
            stageEncounterIDs: ["jmt.journal_1", "jmt.journal_2", "jmt.journal_3"],
            completionBadgeID: "sierra_storyteller"
        )
    ]

    // MARK: - Encounters (~20)

    static let encounters: [EncounterEvent] = [
        // --- Standalone encounters ---
        EncounterEvent(
            id: "jmt.mist_trail_fork",
            triggerMile: 3.2,
            title: "The Mist Trail Fork",
            body: "You reach a split. Left climbs the steep Mist Trail past Vernal Falls — harder but shorter. Right takes the John Muir Trail switchbacks — gentler, longer.",
            choices: [
                Choice(id: "mist", label: "Take the Mist Trail", moraleDelta: 5, energyDelta: -8, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "You climb the stone steps through spray. By the top your legs burn, but the valley beneath you is emerald and thundering."),
                Choice(id: "switchbacks", label: "Stay on the switchbacks", moraleDelta: 2, energyDelta: 0, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "Steady. Easy. The miles pass without drama, and you arrive fresh at Nevada Fall.")
            ],
            defaultChoiceID: "switchbacks",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "jmt.afternoon_storm",
            triggerMile: 8.5,
            title: "Thunderheads",
            body: "Clouds stack over the high country. You hear thunder still far off. A flat granite slab ahead offers open ground — not where you want to be if the storm arrives.",
            choices: [
                Choice(id: "shelter", label: "Shelter under pines", moraleDelta: 0, energyDelta: -2, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You wait an hour in the dripping trees. When you emerge, the trail smells of wet stone and everything is washed clean."),
                Choice(id: "push", label: "Push on through", moraleDelta: 8, energyDelta: -10, badgeAwarded: "storm_chaser", followupEncounterID: nil,
                       resultText: "Hail stings your hands. Lightning cracks somewhere close. You come through it wet, alive, and somehow taller.")
            ],
            defaultChoiceID: "shelter",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "jmt.share_trail_mix",
            triggerMile: 12.1,
            title: "A Hungry Hiker",
            body: "A NOBO thru-hiker — skinny, wind-burned — admits their food bag is light. You have enough to share, barely.",
            choices: [
                Choice(id: "share", label: "Share your trail mix", moraleDelta: 10, energyDelta: -3, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "They eat like it is the first food they've seen in a week. You trade stories of the trail ahead."),
                Choice(id: "decline", label: "Apologize and keep walking", moraleDelta: -5, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You nod and move on. The trail ahead feels a little quieter than it did.")
            ],
            defaultChoiceID: "share",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "jmt.marmot_encounter",
            triggerMile: 20.0,
            title: "The Marmot",
            body: "A fat yellow-bellied marmot sits on a rock, watching you eat lunch. He inches closer. He wants your cheese.",
            choices: [
                Choice(id: "defend", label: "Defend your lunch", moraleDelta: 3, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You hiss like a very small bear. The marmot considers his options and waddles off, offended."),
                Choice(id: "offer", label: "Toss him a crust", moraleDelta: -2, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "A park ranger would frown. The marmot does not frown. He is delighted. Tomorrow he will steal from someone else.")
            ],
            defaultChoiceID: "defend",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "jmt.creek_ford",
            triggerMile: 48.0,
            title: "Cold Creek",
            body: "A snowmelt creek cuts across the trail — thigh-deep, fast, and very, very cold. A log bridge lies fifty yards upstream, slick with moss.",
            choices: [
                Choice(id: "ford", label: "Ford the creek", moraleDelta: 4, energyDelta: -6, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "Ice-water bites your shins. You whoop crossing the far bank, feet stone-numb and somehow laughing."),
                Choice(id: "bridge", label: "Balance across the log", moraleDelta: 2, energyDelta: -3, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You inch across like a tightrope. You do not fall. You consider this a personal victory.")
            ],
            defaultChoiceID: "bridge",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "jmt.ranger_checkin",
            triggerMile: 55.0,
            title: "Ranger Station",
            body: "A back-country ranger waves you over. They want to see your permit and talk about bear activity up ahead.",
            choices: [
                Choice(id: "chat", label: "Stop and chat", moraleDelta: 5, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "Twenty minutes of good conversation. They tell you the best tarn to camp near tonight. Worth every minute."),
                Choice(id: "brief", label: "Keep it brief", moraleDelta: 1, energyDelta: 1, badgeAwarded: "ultralight", followupEncounterID: nil,
                       resultText: "Permit shown, trail conditions noted, back on the path. The light is good and you are making time.")
            ],
            defaultChoiceID: "chat",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "jmt.evolution_basin",
            triggerMile: 105.0,
            title: "Evolution Basin",
            body: "You enter a cirque of granite so wide and pale it feels like walking on the moon. A rare clear pool beckons — but the water is snowmelt cold.",
            choices: [
                Choice(id: "swim", label: "Strip down and plunge", moraleDelta: 12, energyDelta: -8, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "Your whole nervous system resets. You lie on a warm rock afterward and decide this is what the word 'alive' was invented for."),
                Choice(id: "walk", label: "Just dip your feet", moraleDelta: 4, energyDelta: -1, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "The cold creeps up your ankles. You close your eyes. Evolution Basin keeps being there.")
            ],
            defaultChoiceID: "walk",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "jmt.altitude_warning",
            triggerMile: 130.0,
            title: "Thinning Air",
            body: "Headache. Nausea. You're over 11,000 feet and climbing. A flat spot here would make a safe camp — but you're behind schedule.",
            choices: [
                Choice(id: "camp", label: "Camp low, acclimate", moraleDelta: 2, energyDelta: 10, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You wake clear-headed and strong. The pass tomorrow will still be there."),
                Choice(id: "push_up", label: "Push higher anyway", moraleDelta: -3, energyDelta: -12, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "You make camp at altitude with a pounding skull. Dinner tastes like cardboard. You sleep badly but you made miles.")
            ],
            defaultChoiceID: "camp",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "jmt.lost_blaze",
            triggerMile: 145.0,
            title: "Where Did the Trail Go",
            body: "You've been following a use-trail that simply... stopped. The JMT is somewhere to the east. A faint path angles uphill. The map says go back a quarter mile.",
            choices: [
                Choice(id: "backtrack", label: "Backtrack to the last blaze", moraleDelta: -2, energyDelta: -3, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "Annoying but correct. You find the JMT waiting where you left it, as it had been all along."),
                Choice(id: "bushwhack", label: "Navigate cross-country", moraleDelta: 3, energyDelta: -6, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "You bushwhack over granite and manzanita, compass in hand. Forty minutes later you hit the JMT feeling very pleased with yourself.")
            ],
            defaultChoiceID: "backtrack",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "jmt.sunset_ridge",
            triggerMile: 168.0,
            title: "Sunset on the Ridge",
            body: "The sun is setting and a high ridge to the west is turning gold. You could push on to camp below treeline — or stay here for the view.",
            choices: [
                Choice(id: "stay", label: "Stay and watch", moraleDelta: 10, energyDelta: -2, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "For twenty minutes nothing on earth is worth more than what you are looking at."),
                Choice(id: "descend", label: "Descend before dark", moraleDelta: 3, energyDelta: 2, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You hit camp as the first stars come out. A reasonable choice, reasonably taken.")
            ],
            defaultChoiceID: "stay",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),
        EncounterEvent(
            id: "jmt.summit_weather",
            triggerMile: 205.0,
            title: "Whitney Weather Window",
            body: "You reach Trail Camp at the base of Whitney. A summit push at 3am gives you the best weather window. Or you could sleep in, see what the sky brings.",
            choices: [
                Choice(id: "alpine", label: "Alpine start at 3am", moraleDelta: 6, energyDelta: -8, badgeAwarded: "peak_bagger", followupEncounterID: nil,
                       resultText: "Stars and headlamp and 99 switchbacks. You hit the summit ridge at first light."),
                Choice(id: "sleep", label: "Sleep in, take your chances", moraleDelta: 2, energyDelta: 5, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You wake rested. Clouds are building but the window holds. You make it.")
            ],
            defaultChoiceID: "alpine",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: nil
        ),

        // --- Lost Hiker subquest (3 stages) ---
        EncounterEvent(
            id: "jmt.lost_hiker_1",
            triggerMile: 25.0,
            title: "A Worried Face",
            body: "A woman at a junction looks up, startled. Her friend went ahead two hours ago and hasn't come back. She's trying not to panic.",
            choices: [
                Choice(id: "help", label: "Help her look", moraleDelta: 4, energyDelta: -3, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You scan the side trails with her, call her friend's name. Nothing yet — but she's not alone now."),
                Choice(id: "note", label: "Promise to watch for them", moraleDelta: 1, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You take her friend's description. You'll keep an eye out up the trail.")
            ],
            defaultChoiceID: "help",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "lost_hiker"
        ),
        EncounterEvent(
            id: "jmt.lost_hiker_2",
            triggerMile: 31.0,
            title: "A Discarded Pack",
            body: "A day-pack sits unattended on a rock, the description matches. A water bottle, a half-eaten bar. No person.",
            choices: [
                Choice(id: "search", label: "Search the area carefully", moraleDelta: 5, energyDelta: -4, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "Forty minutes of calling and peering. You spot a bootprint heading toward a stream. A lead."),
                Choice(id: "report", label: "Leave a note, report at Tuolumne", moraleDelta: 2, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You mark the pack with flagging tape and make a note of the coordinates. The ranger will want to know.")
            ],
            defaultChoiceID: "search",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "lost_hiker"
        ),
        EncounterEvent(
            id: "jmt.lost_hiker_3",
            triggerMile: 38.0,
            title: "Reunion at Tuolumne",
            body: "At the Tuolumne ranger station, the lost hiker is sitting on a bench, sunburnt and sheepish. Rangers are finishing paperwork. She sees you and stands up.",
            choices: [
                Choice(id: "hug", label: "Accept the hug", moraleDelta: 10, energyDelta: 0, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "She tells you she got turned around on a side trail and finally self-rescued back to the road. She wants your address. She wants to send cookies."),
                Choice(id: "wave", label: "Wave and press on", moraleDelta: 5, energyDelta: 1, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "She calls thanks across the lot. You give a tired wave and keep walking south. The trail is long.")
            ],
            defaultChoiceID: "hug",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "lost_hiker"
        ),

        // --- Bear Country subquest ---
        EncounterEvent(
            id: "jmt.bear_country_1",
            triggerMile: 70.0,
            title: "Bear Notice",
            body: "A ranger has nailed a notice to a trailhead post. A bear has been raiding camps between here and Muir Pass. Use canisters, hang nothing.",
            choices: [
                Choice(id: "canister", label: "Double-check your canister", moraleDelta: 2, energyDelta: 0, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "Lid sealed. Gear sorted. You feel slightly smug about it."),
                Choice(id: "shrug", label: "You've hiked here before", moraleDelta: -1, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You've seen bears. You know the drill. Probably fine.")
            ],
            defaultChoiceID: "canister",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "bear_country"
        ),
        EncounterEvent(
            id: "jmt.bear_country_2",
            triggerMile: 85.0,
            title: "A Visitor at Midnight",
            body: "Something heavy is outside your tent. A snuffling. A paw rolls your canister experimentally across the granite. The bear has arrived.",
            choices: [
                Choice(id: "scare", label: "Shout and bang pots", moraleDelta: 4, energyDelta: -3, badgeAwarded: "trailblazer", followupEncounterID: nil,
                       resultText: "You make yourself huge and loud. The bear huffs, unimpressed, then ambles off. You do not sleep much."),
                Choice(id: "hide", label: "Stay still and quiet", moraleDelta: -3, energyDelta: -2, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You hold your breath for twenty minutes. The canister rolls. Eventually, the bear loses interest.")
            ],
            defaultChoiceID: "scare",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "bear_country"
        ),
        EncounterEvent(
            id: "jmt.bear_country_3",
            triggerMile: 100.0,
            title: "A Cub in Distress",
            body: "A cub is stuck in a dumpster at a JMT resupply cache. Mom is nowhere to be seen — yet. The cub is panicking.",
            choices: [
                Choice(id: "tip", label: "Tip the dumpster gently", moraleDelta: 8, energyDelta: -4, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "The cub tumbles free and bolts into the brush. Somewhere, mom is watching. You back away slowly."),
                Choice(id: "ranger", label: "Radio the ranger", moraleDelta: 4, energyDelta: 0, badgeAwarded: "cautious_hiker", followupEncounterID: nil,
                       resultText: "You get through on the resupply radio. The ranger arrives in thirty minutes and handles it. The cub is fine.")
            ],
            defaultChoiceID: "ranger",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "bear_country"
        ),

        // --- Trail Journal subquest ---
        EncounterEvent(
            id: "jmt.journal_1",
            triggerMile: 42.0,
            title: "A Notebook",
            body: "At a shelter you find a battered waterproof notebook. The last entry is dated six years ago. It asks the next hiker to keep writing.",
            choices: [
                Choice(id: "keep", label: "Take it, write an entry", moraleDelta: 6, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You write about today's weather and how the pass looked at dawn. You pack the notebook carefully."),
                Choice(id: "leave", label: "Leave it for someone else", moraleDelta: 0, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You set it back on the shelf. Someone will find it. Someone always does.")
            ],
            defaultChoiceID: "keep",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "trail_journal"
        ),
        EncounterEvent(
            id: "jmt.journal_2",
            triggerMile: 90.0,
            title: "A Stranger's Story",
            body: "You meet a quiet hiker at a high tarn. When they see the journal, they go very still, then ask if they can read it. Their grandfather's handwriting is in it.",
            choices: [
                Choice(id: "share", label: "Sit and read together", moraleDelta: 12, energyDelta: 0, badgeAwarded: "good_samaritan", followupEncounterID: nil,
                       resultText: "For an hour you read the old entries aloud. They cry. You cry, a little. The tarn keeps being blue."),
                Choice(id: "trade", label: "Offer to give it to them", moraleDelta: 7, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "They shake their head. 'Finish it. Leave it at the summit hut. Others need it too.' They press your hand and go.")
            ],
            defaultChoiceID: "share",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "trail_journal"
        ),
        EncounterEvent(
            id: "jmt.journal_3",
            triggerMile: 210.0,
            title: "The Summit Hut Shelf",
            body: "Inside the stone hut at Whitney's summit, a shelf holds water bottles and scraps of trail magic. You add the notebook. You write the last page.",
            choices: [
                Choice(id: "close", label: "Sign your name and close it", moraleDelta: 15, energyDelta: 0, badgeAwarded: "sierra_storyteller", followupEncounterID: nil,
                       resultText: "You sign the date, the mile count, and a line about what the trail gave you. Another hiker will carry it on."),
                Choice(id: "keep_forever", label: "Pocket it instead", moraleDelta: -4, energyDelta: 0, badgeAwarded: nil, followupEncounterID: nil,
                       resultText: "You carry it out. It feels heavier in your pack than it did on the trail. Some things were meant to stay moving.")
            ],
            defaultChoiceID: "close",
            timeoutSeconds: EncounterEvent.defaultTimeout,
            subquestID: "trail_journal"
        )
    ]
}
