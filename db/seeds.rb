


    def count_word_frequency_en(content)
        # for english words
        words = content.scan(/\w*/).select {|word| !word.empty? && word.to_i == 0 && word.size > 1 && word.size <15}
        word_frequency_en = Hash.new(0)
        words.each { |word| word_frequency_en[word.downcase] += 1 }

        stopword_file = 'app/assets/stop_word.json'
        file = File.read(stopword_file)
        stop_words = JSON.parse(file)

        puts stop_words
        stop_words.each do |word|
            word_frequency_en.delete_if {|key, value| key == word}
        end

        word_frequency_en
    end


    content = "orem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with:

    “Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.”
    The purpose of lorem ipsum is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn't distract from the layout. A "

    puts count_word_frequency_en(content)
    