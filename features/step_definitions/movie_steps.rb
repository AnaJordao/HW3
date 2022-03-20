Given /the following movies exist:/ do |dados|  # dados será a tabela de filmes
    dados.hashes.each do |linha|                # transforma dados num hash em q a chave é o header da tabela
        # usa o create do ActiveRecord do model Movie
        Movie.create(:title => linha[:title], :release_date => linha[:release_date], :rating => linha[:rating])
    end
end

When /I check the following ratings: (.*)/ do |checked|
    checked.split(', ').each do |rating|
        check("ratings_#{rating}")
    end
end

When /I uncheck the following ratings: (.*)/ do |unchecked|
    unchecked.split(', ').each do |rating|
        uncheck("ratings_#{rating}")
    end
end