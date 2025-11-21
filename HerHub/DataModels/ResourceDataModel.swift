
//
//  ResourceManager.swift
//  HerHub
//
//  Created by Mahika Behal on 28/10/25.
//

import Foundation

class ResourceManager {
    static let shared = ResourceManager()
    
    private let documentsDirectory: URL
    private let archiveURL: URL
    private var resources: [Resource] = []
    
    private init() {
        // Locate app's Documents directory
        documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        archiveURL = documentsDirectory.appendingPathComponent("Resources").appendingPathExtension("plist")
        
        loadResources()
    }
    
    // MARK: - Public Access
    func getAllResources() -> [Resource] {
        return resources
    }
    
    func addResource(_ resource: Resource) {
        resources.append(resource)
        saveResources()
    }
    
    func updateResource(_ resource: Resource) {
        if let index = resources.firstIndex(where: { $0.id == resource.id }) {
            resources[index] = resource
            saveResources()
        }
    }
    
    func deleteResource(at index: Int) {
        resources.remove(at: index)
        saveResources()
    }
    
    func toggleBookmark(for id: UUID) {
        if let index = resources.firstIndex(where: { $0.id == id }) {
            resources[index].isBookmarked.toggle()
            saveResources()
        }
    }
    
//    func toggleLike(for id: UUID) {
//        if let index = resources.firstIndex(where: { $0.id == id }) {
//            resources[index].isLiked.toggle()
//            saveResources()
//        }
//    }
    func toggleLike(resourceId: UUID, userId: UUID) {
        guard let index = resources.firstIndex(where: { $0.id == resourceId }) else { return }

        // Ensure the array exists
        if resources[index].isLiked == nil {
            resources[index].isLiked = []
        }

        // Check if user already liked
        if let position = resources[index].isLiked?.firstIndex(of: userId) {
            // User already liked → remove like
            resources[index].isLiked?.remove(at: position)
        } else {
            // User is liking for the first time → add userId
            resources[index].isLiked?.append(userId)
        }

        saveResources()
    }

    
    // MARK: - Persistence
//    private func loadResources() {
//        if let savedResources = loadResourcesFromDisk() {
//            resources = savedResources
//        } else {
//            resources = loadSampleResources()
//            saveResources() // Save sample on first run
//        }
//    }
    private func loadResources() {
        // Always load fresh sample data for now
        resources = loadSampleResources()
        saveResources()
//        if let savedData = loadResourcesFromDisk() {
//              // LOAD DATA FROM DISK
//              resources = savedData
//          } else {
//              // FIRST TIME → LOAD SAMPLE DATA
//              resources = loadSampleResources()
//              saveResources()  // save sample data
//          }
    }

    
    private func loadResourcesFromDisk() -> [Resource]? {
        guard let codedData = try? Data(contentsOf: archiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode([Resource].self, from: codedData)
    }
    
    private func saveResources() {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        if let codedData = try? encoder.encode(resources) {
            try? codedData.write(to: archiveURL, options: .noFileProtection)
        }
    }
    func getResource(by id: UUID) -> Resource? {
        return resources.first(where: { $0.id == id })
    }

    
    // MARK: - Sample Data
    // MARK: - Sample Data
    private func loadSampleResources() -> [Resource] {
        return [
            Resource(
                title: "Understanding Your Menstrual Cycle",
                description: "A comprehensive guide to understanding the four phases of your menstrual cycle and what to expect.",
                detailSubtitle: "Understanding your cycle isn’t just science — it’s a form of self-love and emotional awareness.",

                category: .featured,
                content: """
                Your menstrual cycle is not just something that happens once a month — it affects your body every single day. It changes your energy, mood, skin, cravings, confidence, and even the way you think.

                When you understand your cycle, you learn how to work with your body, not against it. And that is one of the most empowering things a girl can do.

                ✨ The Four Phases of Your Cycle
                1. Menstrual Phase (Period Days)

                This is when your body needs extra care. Your hormones drop, so you may feel tired, emotional, or low-energy.

                Your body is asking for rest — and that’s completely normal.
                Warm foods, gentle routines, and quiet time help you feel better.

                2. Follicular Phase (Fresh Start Phase)

                After your period, your energy rises again. You may feel creative, motivated, and mentally clear.

                Many girls describe this as a fresh, positive start.

                3. Ovulation Phase (Peak Confidence Phase)

                This is your high-energy and high-confidence time.
                You may feel more social, active, and glowing.

                It’s a great time for presentations, workouts, social events, or big tasks.

                4. Luteal Phase (Slow Down Phase)

                Your body starts preparing for your next cycle. You might experience PMS — cravings, mood changes, bloating, or irritability.

                This doesn’t mean something is wrong.
                Your body is working hard behind the scenes.

                Gentle movement, mindful eating, hydration, and self-care can really help.

                🌷 Why Understanding Your Cycle Matters

                When you learn these phases, you stop feeling confused by sudden mood or energy changes.

                You begin treating yourself with kindness and patience.

                And you realize:

                Your body is not working against you — it’s talking to you.
                When you listen, life feels calmer, easier, and more aligned with who you are.
                """,
                author: "🩺 Dr. Meenakshi Gupta",
                estimatedReadTime: "5 min read",
                imageURL: "menstrual_cycle_image"
            ),
            Resource(
                title: "Mental Health & Yoga Cycle",
                description: "Discover how yoga and mindfulness can help manage PMS symptoms and improve overall well-being.",
                detailSubtitle: "How movement, breathwork, and mindfulness help you find emotional balance through every phase of your cycle.",
                category: .health,
                content: """
                Your mental health and your hormones are deeply connected — much more than most girls ever learn.
                Every phase of your cycle changes the way you think, feel, react, and handle emotions.

                Understanding this isn’t just helpful —
                it can completely change the way you care for yourself.

                ✨ Follicular Phase — Your “Feel Good” Phase

                During this phase, estrogen rises and boosts your serotonin and dopamine, also known as the “happy hormones.”

                This means you naturally feel:

                 ✔ Motivated
                 ✔ Focused
                 ✔ Emotionally lighter
                 ✔ Ready to try new things

                 This is the best time to start habits, make plans, begin projects, or socialize.

                 ✨ Luteal Phase — Your Sensitive Phase

                 As you move into the luteal phase, progesterone increases.
                 For many girls, this brings:

                 • Irritability
                 • Anxiety
                 • Emotional sensitivity
                 • Sadness or moodiness

                 But remember:
                 You are not weak — your body is doing powerful hormonal work inside you.

                 ✨ Why Yoga & Mindfulness Help

                 This is where yoga and mindfulness become your superpower.
                 They help your mind and body relax and restore balance.

                 🧘‍♀️ Slow breathing → calms your nervous system
                 🧘‍♀️ Gentle yoga → reduces cramps, bloating, and mood swings
                 🧘‍♀️ Meditation → helps you react more peacefully and clearly

                 Mindfulness gives you space to breathe instead of feeling overwhelmed.

                 ✨ Movement Doesn’t Need to Be Hard

                 You don’t need intense workouts every day.
                 Sometimes the best thing you can do is:

                 • A slow stretch
                 • Deep breathing
                 • A gentle walk
                 • Sitting in calm silence

                 You’re not meant to be at 100% energy all month — and that’s okay.

                 🌷 What Happens When You Move With Your Cycle

                 When you match yoga and mindfulness with your hormonal rhythm, something beautiful happens:

                 You feel more in control.
                 You feel calmer.
                 You feel more connected to your body.
                 Life starts to feel softer and easier.

                 You become more patient, more grounded, and more emotionally balanced — not by forcing yourself, but by understanding yourself.
""",
                author: "🩺 Dr. Meera Sharma",
                estimatedReadTime: "5 min read",
                imageURL: "yoga_cycle_image"
            ),
            Resource(
                        title: "Stress Management Techniques",
                        description: "Effective strategies to manage stress and maintain emotional balance throughout your cycle.",
                        detailSubtitle: "Simple, science-backed ways to calm your mind, relax your body, and handle everyday stress with confidence."
,
                        category: .lifestyle,
                        content: """
                        Food isn’t just fuel —
                        it’s one of the kindest forms of care you can give your hormones.

                        When you eat according to your menstrual cycle, your:

                        ✨ Energy becomes more stable
                        ✨ Mood feels balanced
                        ✨ Skin improves
                        ✨ Cravings reduce
                        ✨ Period pain becomes easier

                        Your body communicates with you every day — and food is one of the best ways to support it.

                        ❤️ Menstrual Phase — Your Comfort Phase

                        During your period, your body loses iron and works hard to restore itself.
                        This is the time for warm, soft, comforting meals that make you feel held and nourished.

                        The best foods include:
                        ✔ Warm soups
                        ✔ Dals and khichdi
                        ✔ Leafy greens
                        ✔ Jaggery
                        ✔ Nuts and seeds
                        ✔ Herbal teas

                        These foods rebuild your strength and reduce tiredness.

                        🌱 Follicular Phase — Your Fresh Start Phase

                        After your period ends, your energy naturally rises.
                        Your body loves fresh, colorful, light foods that feel refreshing and clean.

                        Great choices are:
                        ✔ Fruits
                        ✔ Smoothies
                        ✔ Salads
                        ✔ Oats
                        ✔ Yogurt

                        This is a phase where you feel renewed — let your food reflect that.

                        ✨ Ovulation — Your Glow Phase

                        During ovulation, your body is at its strongest and most vibrant.

                        To support this peak, focus on:
                        ✔ High-fiber foods
                        ✔ Lean proteins
                        ✔ Antioxidant-rich meals

                        Try things like berries, eggs, quinoa, and lots of green veggies.
                        These keep your blood sugar steady and help you maintain that natural glow.

                        🍫 Luteal Phase — Your Craving Phase

                        This is the phase before your period, when cravings feel stronger — and that’s completely normal.

                        Instead of fighting your cravings, choose foods that nourish you and comfort you:

                        ✔ Dark chocolate
                        ✔ Bananas
                        ✔ Nuts and seeds
                        ✔ Warm meals
                        ✔ Complex carbs (oats, sweet potatoes, whole grains)

                        These foods help reduce bloating, cramps, and mood swings.

                        Remember:
                        Your cravings aren’t “bad.” They’re your body talking to you.

                        🌼 Eating for Your Cycle Is Not a Diet

                        It’s about kindness, awareness, and listening.

                        When you give your body what it genuinely needs:

                        ✨ Your mood becomes stable
                        ✨ Your energy becomes consistent
                        ✨ Your relationship with food becomes peaceful
                        ✨ You feel more connected with your body

                        Cycle syncing is simply:
                        choosing foods that love you back.
""",
                        author: "🩺 Dr. Kavya Nair",
                        estimatedReadTime: "6 min read",
                        imageURL: "stress_management_image"
                    ),
            Resource(
                title: "Nutrition During Your Cycle",
                description: "Learn about the best foods to eat during different phases of your cycle for optimal health.",
                detailSubtitle: "Discover how the food you eat can support your hormones, energy, mood, and overall well-being all month long.",
                category: .wellness,
                content: """
               Food is not just something you eat —
               it’s therapy for your hormones, your mood, your skin, and your energy.

               When you start eating according to your menstrual cycle, you feel:

               ✨ More energetic
               ✨ Less moody
               ✨ More balanced
               ✨ Less bloated
               ✨ More in control of your cravings

               Your body has different needs in each phase, and listening to them can change everything.

               ❤️ Menstrual Phase — Your Comfort Phase

               When you’re on your period, your body loses iron and energy.
               This is the time to be gentle with yourself.

               Your body loves:

               ✔ Warm soups
               ✔ Dals and khichdi
               ✔ Leafy green vegetables
               ✔ Jaggery
               ✔ Nuts and seeds
               ✔ Warm herbal teas

               These foods help reduce fatigue, relax your body, and bring back strength.

               Think: warm, comforting, nourishing.

               🌱 Follicular Phase — Your Fresh Energy Phase

               Right after your period, your energy starts rising again.
               You feel lighter, refreshed, and more creative.

               Eat foods that feel:

               ✔ Fresh
               ✔ Colorful
               ✔ Hydrating

               Like fruits, smoothies, salads, oats, and yogurt.

               This phase is all about feeling fresh, light, and ready to start again.

               ✨ Ovulation — Your Glow Phase

               This is your body at its absolute best —
               strong, confident, social, and full of natural glow.

               Support this phase with foods that keep your energy steady:

               ✔ High-fiber foods
               ✔ Lean protein
               ✔ Antioxidants

               Try foods like berries, eggs, quinoa, paneer, lentils, and lots of green vegetables.

               This is your “shine” phase — let your food help you glow.

               🍫 Luteal Phase — Your Craving Phase

               This is the phase before your period.
               Your hormones shift, and cravings become stronger — and that is completely normal.

               Instead of fighting cravings, choose comforting + healthy options:

               ✔ Dark chocolate (rich in magnesium)
               ✔ Bananas
               ✔ Nuts and seeds
               ✔ Complex carbs
               ✔ Warm meals
               ✔ Hydration

               These help reduce cramps, mood swings, bloating, and irritation.

               Your cravings are not a sign of weakness — they’re your body asking for support.

               🌼 This Isn’t a Diet — It’s Self-Care

               Eating for your cycle is about listening to your body, being kind to yourself, and giving your hormones what they need.

               When you do this:

               ✨ Your mood becomes calm
               ✨ Your cravings become gentle
               ✨ Your energy feels stable
               ✨ Your body feels lighter
               ✨ Your relationship with food becomes peaceful

               Cycle syncing is simply understanding:
               “My body changes — and that’s okay. I can support it with love.”
""",
                author: "Nutritionist Ananya Rao",
                estimatedReadTime: "6 min read",
                imageURL: "nutrition_image"
            ),
            Resource(
                title: "Exercise and Your Hormones",
                description: "Learn how to adjust your workout routine to work with your hormonal changes.",
                detailSubtitle: "Learn how to sync your workouts with your natural hormonal flow to feel stronger, energized, and motivated.",
                category: .fitness,
                content:"""
               Your workout doesn’t need to look the same every day —
               because you don’t feel the same every day.
               Your hormones shift throughout the month, and they influence your strength, motivation, and energy more than you realize.

               Once you learn to move with your cycle instead of against it, fitness becomes:

               ✔ Easier
               ✔ More enjoyable
               ✔ Less exhausting
               ✔ Way more effective

               Let’s break it down beautifully 💛

               ❤️ Menstrual Phase — Your Rest & Recover Phase

               This is when your body says:
               “Slow down. I’m healing.”

               During your period, it’s normal to feel low energy.
               Choose gentle movements like:

               ✔ Light stretching
               ✔ Slow yoga
               ✔ A relaxed walk
               ✔ Deep breathing

               These help ease cramps, relax your mind, and reduce stress — without tiring you out.

               Resting isn’t being lazy — it’s being wise.

               🌱 Follicular Phase — Your “Fresh Start” Phase

               As soon as your period ends, your energy begins to rise again.
               You feel lighter, focused, and more motivated.

               This is the perfect time for:

               ✔ Strength training
               ✔ Cycling
               ✔ Pilates
               ✔ Trying new workouts
               ✔ Learning new skills

               Your body feels capable and your brain feels creative.

               This is the phase where confidence naturally grows.

               ✨ Ovulation — Your Power Phase

               This is your strongest, most energetic time of the month.
               You feel confident, social, and naturally powerful.

               Try workouts that use your physical peak:

               ✔ HIIT
               ✔ Running
               ✔ Dance workouts
               ✔ Heavy lifting
               ✔ Intense cardio

               Your body handles intensity beautifully during this phase.

               Your power is at its maximum — use it!

               🌙 Luteal Phase — Your Slow-Down Phase

               This is the time before your next period.
               Your hormones shift, your body warms up internally, and energy drops slowly.

               Great workout choices:

               ✔ Light to moderate strength training
               ✔ Yoga
               ✔ Low-impact cardio
               ✔ Stretching
               ✔ Long walks

               These help prevent irritation, bloating, and emotional burnout.

               This is your “be kind to yourself” phase.

               🌼 Celebrate Your Natural Rhythm

               When girls sync their workouts with their cycle, something magical happens:

               ✨ No more guilt on low-energy days
               ✨ No more pushing your body when it’s asking for rest
               ✨ Better results with less exhaustion
               ✨ A peaceful relationship with your body

               You finally understand:
               Your body isn’t inconsistent — it’s beautifully rhythmic.
               And following that rhythm is one of the healthiest things you can do.
""",
                author: "Fitness Coach Priya Singh",
                estimatedReadTime: "7 min read",
                imageURL: "exercise_hormones_image"
            ),
            Resource(
                title: "Sleep and Hormonal Balance",
                description: "Understanding the connection between quality sleep and hormonal health.",
                detailSubtitle: "Good sleep is more than rest — it’s powerful hormonal therapy for your body and mind.",
                category: .wellness,
                content: """
               Sleep is one of the strongest ways to support your hormones —
               yet it’s something most girls unknowingly ignore.
               Your sleep affects your cycle, and your cycle affects your sleep.
               When you start giving rest the importance it deserves,
               your entire body begins to feel calmer, lighter, and more balanced.

               😴 How Poor Sleep Affects You

               When you don’t sleep well, your hormones become stressed. This can lead to:

               More PMS symptoms

               Low mood or irritation

               Increased cravings

               Stress and anxiety

               Irregular cycles

               But when you sleep deeply (even just 7–8 hours):

               ✨ Your mood becomes stable
               ✨ Anxiety reduces
               ✨ Hunger hormones stay in control
               ✨ Your cycle stays more regular
               ✨ You wake up feeling fresh and confident

               Good sleep is basically free therapy for your hormones.

               🌙 The Luteal Phase — Why Sleep Gets Tricky

               Before your period (during the luteal phase), many girls struggle with:

               • Overthinking at night
               • Feeling hot or restless
               • Waking up often
               • Mood swings
               • Irritability

               This happens because your hormones are shifting and your body is preparing for menstruation.

               The solution?

               🌸 Create a slow, soft bedtime routine:

               ✔ Switch off screens early
               ✔ Drink warm herbal tea
               ✔ Stretch lightly
               ✔ Journal or write gratitude
               ✔ Keep your room dim and cool

               Your body responds beautifully to small, soothing habits.

               ☁️ Why Sleep Is Not Just “Closing Your Eyes”

               Sleep is your body’s healing time.

               During deep rest, your body:

               ✔ Repairs your cells
               ✔ Balances hormones
               ✔ Reduces inflammation
               ✔ Calms your nervous system
               ✔ Resets your mood and energy

               A well-rested girl becomes:

               ✨ More confident
               ✨ More focused
               ✨ More emotionally stable
               ✨ More productive
               ✨ More connected to herself

               Prioritize your peace — your body will thank you in ways you can feel every day.
""",
                author: "🩺 Ganesh Mehta",
                estimatedReadTime: "6 min read",
                imageURL: "sleep_balance_image"
            ),
            Resource(
                title: "Managing PMS Naturally",
                description: "Natural remedies and lifestyle changes to help manage PMS symptoms effectively.",
                detailSubtitle: "Gentle lifestyle changes, natural remedies, and supportive habits that make PMS easier to navigate.",
                category: .lifestyle,
                content: """
               PMS doesn’t mean you’re dramatic…
               It doesn’t mean you’re “overreacting”…
               And it definitely doesn’t mean something is wrong with you.

               PMS simply means your body is asking for softness, rest, and care.
               The days before your period can feel emotionally and physically heavy —
               and that’s completely normal.

               💗 Why PMS Happens

               Before your period, your hormones shift.
               This can affect:

               Mood

               Energy

               Patience

               Skin

               Cravings

               Sleep

               You’re not “moody”; your body is working incredibly hard behind the scenes.

               🌿 Small Lifestyle Changes That Make a Big Difference

               These gentle habits can ease PMS symptoms:

               🍵 Warm drinks & herbal teas

               They relax your belly, calm your mind, and reduce cramps.

               🥜 Magnesium-rich foods

               Dark chocolate, bananas, nuts, and seeds help with bloating and mood swings.

               🧘‍♀️ Gentle movement

               Slow yoga, stretching, or a short walk relaxes your muscles and lowers stress.

               🌬️ Mindful breathing

               Just a few minutes can reduce anxiety and irritability.

               🚫 Avoid too much caffeine & salty snacks

               They can worsen bloating and mood.

               ☀️ Stress Makes PMS Worse

               Stress is one of the biggest triggers of PMS symptoms.

               To help your body feel safe and regulated:

               Take small breaks

               Journal your feelings

               Spend time in nature

               Do activities you love

               Rest when you need to

               A calm mind = calmer PMS.

               🌸 What PMS Really Teaches You

               When you treat your body kindly during PMS:

               ✨ You feel less discomfort
               ✨ You become more aware of your emotions
               ✨ You learn patience with yourself
               ✨ You build emotional strength
               ✨ You connect more deeply with your mind and body

               PMS doesn’t define you —
               It teaches you to listen to your body’s needs.

               Whenever you honor your body,
               your body supports you back. 💗✨
""",
                author: "🩺 Arpit Singh",
                estimatedReadTime: "7 min read",
                imageURL: "pms_management_image"
            ),
           
            Resource(
                title: "Hormonal Acne Solutions",
                description: "Understanding and treating hormonal acne with natural and medical approaches.",
                detailSubtitle: "Understand why hormonal acne happens and how to heal your skin with kindness, care, and smart routines.",
                category: .skincare,
                content: """
               Hormonal acne can feel annoying, frustrating, and even unfair —
               especially when it appears around the same time every month.
               But here’s something important:

               Hormonal acne is not a flaw.
               It’s your body communicating with you.

               During the luteal phase (the week before your period), hormones like progesterone rise, and that can cause breakouts — especially around your chin and jawline.
               It’s your body reacting to changes that are completely normal.

               💧 Gentle Care Works Better Than Harsh Treatments

               Many people think scrubbing harder or using strong products will “fix” acne.
               But in reality, your skin needs the opposite — calmness and care.

               What actually helps:

               Non-comedogenic (doesn’t clog pores) products

               Mild, gentle cleansers

               A simple, consistent routine

               Ingredients like:

               Salicylic Acid (clears pores)

               Niacinamide (reduces redness + strengthens skin)

               Tea Tree (natural antibacterial)

               These ingredients calm your skin instead of irritating it.

               🧘‍♀️ Your Lifestyle Affects Your Skin Too

               Hormonal acne isn’t just about skincare — it’s also about how your body feels inside.
               Things that can make acne worse:

               Dehydration

               Stress

               Not sleeping enough

               High sugar foods

               Skipping meals

               Things that help your skin heal from within:

               Drinking enough water

               Sleeping 7–8 hours

               Managing stress gently

               Eating balanced meals

               Giving your skin time to recover

               Your skin reflects your habits — not your beauty.

               💗 Be Kind to Yourself

               Breakouts don’t make you unattractive.
               They don’t make you “less than.”
               They don’t define your worth.

               What truly matters is how you treat yourself.

               Acne is temporary.
               Your confidence is permanent.

               With patience, gentle routines, and the right habits,
               your skin will return to balance — and so will you. ✨💕
""",
                author: "🩺 Dr. Aarohi Mehta",
                estimatedReadTime: "6 min read",
                imageURL: "hormonal_acne_image"
            )
        ]
    }

}
