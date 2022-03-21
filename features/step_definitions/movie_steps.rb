Given /the following movies exist:/ do |dados|  # dados será a tabela de filmes
    @linhas_totais = 0
    dados.hashes.each do |linha|                # transforma dados num hash em q a chave é o header da tabela
        # usa o create do ActiveRecord do model Movie
        Movie.create(:title => linha[:title], :release_date => linha[:release_date], :rating => linha[:rating])
        @linhas_totais += 1
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

Then /I should see all of the movies/ do
    if page.respond_to? :should
      page.should has_css("table#movies tbody tr", :count => @linhas_totais)
    else
      assert page.has_css?("table#movies tbody tr", :count => @linhas_totais)
    end
end

When /I check all ratings/ do 
    if page.respond_to? :should
        page.should has_css("table#movies tbody tr", :count => @linhas_totais)
    else
        assert page.has_css?("table#movies tbody tr", :count => @linhas_totais)
    end
end

Then /I should see "(.*)" before "(.*)"/ do |first, second|
    first = page.body.index(first)
    second = page.body.index(second)

    assert(first < second)
end