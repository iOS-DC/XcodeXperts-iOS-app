
//
//  ResourceManager.swift
//  HerHub
//
//  Created by Mahika Behal on 28/10/25.
//
//....mam mam
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
    
    func toggleLike(for id: UUID) {
        if let index = resources.firstIndex(where: { $0.id == id }) {
            resources[index].isLiked.toggle()
            saveResources()
        }
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
    
    // MARK: - Sample Data
    // MARK: - Sample Data
    private func loadSampleResources() -> [Resource] {
        return [
            Resource(
                title: "Understanding Your Menstrual Cycle",
                description: "A comprehensive guide to understanding the four phases of your menstrual cycle and what to expect.",
                category: .featured,
                content: """
                Your menstrual cycle is more than a monthly routine — it’s a rhythm your body follows every single day, quietly influencing your energy, mood, skin, cravings, confidence, and even the way you think. When you understand what’s happening inside your body, you learn to work *with* your cycle instead of struggling against it, and that is one of the most empowering things a girl can do for herself.
                Your cycle has four phases, and each one has its own personality. During the Menstrual Phase, your hormones drop and your body asks for gentleness. You might feel more emotional or tired, and that’s completely normal. This is the time for warm foods, rest, soft routines, and listening to your body.
                As you move into the Follicular Phase, your energy naturally rises. Your mind becomes clearer, your creativity flows, and you may feel more motivated to try new things. Many girls describe this phase as feeling like a “fresh start.”
                Ovulation is your high-vibes moment. You usually feel confident, social, and naturally glowing inside and out. Your communication skills peak, and you may feel more connected to the people around you. It’s a great time for presentations, workouts, and big tasks.
                The Luteal Phase follows, and this is where your body slows down again. You may notice PMS signs like cravings, mood changes, or bloating — not because something is wrong, but because your body is working hard behind the scenes. Gentle exercise, nutritious snacks, hydration, and self-care can make this phase much easier.
                When you understand these phases, you no longer feel confused by sudden mood changes or shifts in energy. You begin treating yourself with compassion. You realize your body is not working *against* you — it’s speaking to you. And once you start listening, life becomes calmer, kinder, and so much more aligned with who you are.
                """,
                author: "HerHub Experts",
                estimatedReadTime: "5 min read",
                imageURL: "menstrual_cycle_image"
            ),
            Resource(
                title: "Mental Health & Yoga Cycle",
                description: "Discover how yoga and mindfulness can help manage PMS symptoms and improve overall well-being.",
                category: .health,
                content: """
 Your mental health is deeply connected to your hormones — far more than most girls are ever taught. Every shift in your cycle influences the way you think, feel, and react. Understanding this connection isn’t just helpful; it’s life-changing.
                
                During the follicular phase, rising estrogen boosts serotonin and dopamine, the “happy hormones.” This makes you feel motivated, focused, and emotionally lighter. It’s the perfect time to try new habits, start projects, or engage in social activities.

                However, as you enter the luteal phase, your hormone levels change again. Progesterone rises, and for many girls, this can bring irritability, anxiety, or sadness. You might feel more emotional or sensitive during this time — not because you’re weak, but because your body is doing incredibly complex work.

                This is where yoga and mindfulness become powerful tools. Slow breathing techniques help calm your nervous system, easing anxiety and emotional overwhelm. Gentle yoga sequences can reduce PMS symptoms like cramps, bloating, and mood swings. Meditation helps you create space between your emotions and your reactions, allowing you to respond with grace instead of frustration.

                Movement during your cycle doesn’t have to be intense. Sometimes, the kindest thing you can give yourself is a slow stretch, a few minutes of deep breathing, or a quiet walk outside. You’re not supposed to be at 100% energy all month long — no one is.

                When you learn to pair yoga and mindfulness with your natural hormonal rhythm, something magical happens: you feel more in control, more grounded, and more connected to your mind and body. It becomes easier to be patient with yourself, and life starts to feel softer, lighter, and much more manageable.
""",
                author: "Dr. Meera Sharma",
                estimatedReadTime: "5 min read",
                imageURL: "yoga_cycle_image"
            ),
            Resource(
                        title: "Stress Management Techniques",
                        description: "Effective strategies to manage stress and maintain emotional balance throughout your cycle.",
                        category: .lifestyle,
                        content: """
Food is not just fuel — it’s therapy for your hormones. Eating in sync with your menstrual cycle can transform your energy levels, mood, skin, cravings, and even period pain. When you understand what your body needs in each phase, you feel stronger, healthier, and more balanced from the inside out.
                        
                        During your Menstrual Phase, your body loses iron and needs warm, comforting meals. Soups, dals, leafy greens, jaggery, nuts, and warm herbal teas support your body beautifully. These foods rebuild your strength and reduce fatigue.

                        In the Follicular Phase, fresh and colorful foods help boost your rising energy. Think fruits, smoothies, salads, oats, and yogurt. This phase is all about feeling fresh, light, and renewed.

                        When Ovulation arrives, your body is at its peak. High-fiber foods, lean proteins, and antioxidants help maintain your glow. Berries, eggs, quinoa, and green vegetables help stabilize your blood sugar and keep your energy steady.

                        During the Luteal Phase, cravings hit — and that’s natural. Instead of fighting your cravings, choose foods that nourish your body and emotions. Magnesium-rich foods like dark chocolate, bananas, nuts, and seeds help reduce bloating, cramps, and mood swings. Warm meals, complex carbs, and hydration help you feel calm and grounded.

                        Eating for your cycle isn’t about dieting — it’s about caring for your body with kindness and awareness. When you give your body what it needs, your moods stabilize, your energy improves, and your relationship with food becomes peaceful and intuitive.
""",
                        author: "Dr. Kavya Nair",
                        estimatedReadTime: "6 min read",
                        imageURL: "stress_management_image"
                    ),
            Resource(
                title: "Nutrition During Your Cycle",
                description: "Learn about the best foods to eat during different phases of your cycle for optimal health.",
                category: .wellness,
                content: """
Food is not just fuel — it’s therapy for your hormones. Eating in sync with your menstrual cycle can transform your energy levels, mood, skin, cravings, and even period pain. When you understand what your body needs in each phase, you feel stronger, healthier, and more balanced from the inside out.
                
                During your Menstrual Phase, your body loses iron and needs warm, comforting meals. Soups, dals, leafy greens, jaggery, nuts, and warm herbal teas support your body beautifully. These foods rebuild your strength and reduce fatigue.

                In the Follicular Phase, fresh and colorful foods help boost your rising energy. Think fruits, smoothies, salads, oats, and yogurt. This phase is all about feeling fresh, light, and renewed.

                When Ovulation arrives, your body is at its peak. High-fiber foods, lean proteins, and antioxidants help maintain your glow. Berries, eggs, quinoa, and green vegetables help stabilize your blood sugar and keep your energy steady.

                During the Luteal Phase, cravings hit — and that’s natural. Instead of fighting your cravings, choose foods that nourish your body and emotions. Magnesium-rich foods like dark chocolate, bananas, nuts, and seeds help reduce bloating, cramps, and mood swings. Warm meals, complex carbs, and hydration help you feel calm and grounded.

                Eating for your cycle isn’t about dieting — it’s about caring for your body with kindness and awareness. When you give your body what it needs, your moods stabilize, your energy improves, and your relationship with food becomes peaceful and intuitive.
""",
                author: "Nutritionist Ananya Rao",
                estimatedReadTime: "6 min read",
                imageURL: "nutrition_image"
            ),
            Resource(
                title: "Exercise and Your Hormones",
                description: "Learn how to adjust your workout routine to work with your hormonal changes.",
                category: .fitness,
                content:"""
 Your workout doesn’t have to look the same every day — because your body doesn’t feel the same every day. Once you learn to move in harmony with your hormones, fitness becomes easier, more enjoyable, and far more effective.
                
                During the Menstrual Phase, your body needs rest. Light stretching, slow yoga, or gentle walks help release cramps and reduce stress without overwhelming your energy.

                In the Follicular Phase, your energy naturally returns. This is the perfect time for strength training, pilates, cycling, or trying something new. You’ll feel more motivated and physically capable during this phase.

                When you reach Ovulation, your power peaks. High-intensity workouts like HIIT, running, dancing, or heavy lifting feel natural and exciting. Take advantage of this phase — your body is strong and ready.

                The Luteal Phase is your wind-down time. Opt for moderate workouts like yoga, low-impact cardio, or strength training with lighter intensity. This helps prevent burnout, bloating, and irritation.

                When girls sync their workouts with their cycle, they stop feeling guilty for having “low energy days” and start celebrating their natural rhythm. Your body isn't meant to perform at the same level every week — and that’s a beautiful thing.
""",
                author: "Fitness Coach Priya Singh",
                estimatedReadTime: "7 min read",
                imageURL: "exercise_hormones_image"
            ),
            Resource(
                title: "Sleep and Hormonal Balance",
                description: "Understanding the connection between quality sleep and hormonal health.",
                category: .wellness,
                content: """
Sleep is one of the most powerful ways to support your hormones — yet it’s the one thing most girls overlook. Your cycle affects your sleep patterns, and your sleep affects your cycle in return. When you learn to prioritize rest, your entire body thanks you.
                
                Poor sleep can worsen PMS, increase stress, and disrupt appetite signals. On the other hand, deep, restful sleep stabilizes mood, reduces anxiety, balances hunger hormones, and keeps your menstrual cycle regular.

                During the luteal phase, many girls experience insomnia, irritability, or restless nights due to hormonal shifts. Creating a slow bedtime routine — like switching off screens, drinking warm tea, or journaling — can help calm your mind.

                Good sleep isn’t just about closing your eyes. It’s about giving your body time to heal, reset, and recharge. A well-rested girl is a more confident, focused, and emotionally stable girl. Prioritize your peace, and your body will thank you in ways you can feel every day.
""",
                author: "HerHub Experts",
                estimatedReadTime: "6 min read",
                imageURL: "sleep_balance_image"
            ),
            Resource(
                title: "Managing PMS Naturally",
                description: "Natural remedies and lifestyle changes to help manage PMS symptoms effectively.",
                category: .lifestyle,
                content: """
PMS doesn’t mean you’re dramatic or overreacting. It means your body is asking for care, softness, and rest. The days before your period can feel heavy — emotionally and physically — but small changes in lifestyle can make a huge difference.
                
                Warm water, herbal teas, magnesium-rich foods, gentle movement, and mindful breathing reduce cramps, bloating, and mood swings. Avoiding excessive caffeine and salty snacks helps your body feel lighter and calmer.

                Stress is one of the biggest triggers of PMS. Practicing mindfulness, taking small breaks, doing activities you love, and spending time in nature helps your body feel safe and regulated.

                When you treat your body kindly during PMS, you don’t just reduce discomfort — you strengthen your relationship with yourself. You become more patient, self-aware, and emotionally resilient. PMS doesn’t define you; it teaches you to listen to your body’s needs.
""",
                author: "HerHub Experts",
                estimatedReadTime: "7 min read",
                imageURL: "pms_management_image"
            ),
           
            Resource(
                title: "Hormonal Acne Solutions",
                description: "Understanding and treating hormonal acne with natural and medical approaches.",
                category: .skincare,
                content: """
Hormonal acne can feel frustrating, especially when it appears at the same time every month. But it’s not a flaw — it’s your body communicating with you. Acne around your chin and jawline often increases during the luteal phase because of rising hormones.
                
                Instead of harsh treatments, focus on gentle skincare. Non-comedogenic products, mild cleansers, and consistent routines are far more effective than scrubbing or overwashing. Ingredients like salicylic acid, niacinamide, and tea tree help reduce acne without irritation.

                Your lifestyle also matters. Dehydration, stress, lack of sleep, and sugar spikes can make acne worse. Drinking water, resting well, and eating balanced meals help your skin heal from within.

                Most importantly, be kind to yourself. Acne is normal, temporary, and treatable. With patience, care, and the right routine, your skin will always find its way back to balance.
""",
                author: "Dr. Aarohi Mehta",
                estimatedReadTime: "6 min read",
                imageURL: "hormonal_acne_image"
            )
        ]
    }

}
