Given /the following movies exist:/ do |dados|  # dados será a tabela de filmes
    @linhas_totais = 0                          
    dados.hashes.each do |linha|                # transforma dados num hash em q a chave é o header da tabela
        # usa o create do ActiveRecord do model Movie
        Movie.create(:title => linha[:title], :release_date => linha[:release_date], :rating => linha[:rating])
        @linhas_totais += 1                     # conta as linhas da tabela
    end
end

When /I check the following ratings: (.*)/ do |checked| # pega a lista de ratings como uma string
    checked.split(', ').each do |rating|                # divide a string em cada rating
        check("ratings_#{rating}")                      # seleciona as ratings usando o id do haml
    end
end

When /I uncheck the following ratings: (.*)/ do |unchecked|# pega a lista de ratings como uma string
    unchecked.split(', ').each do |rating|                  # divide a string em cada rating
        uncheck("ratings_#{rating}")                        # uncheck as ratings usando o id do haml
    end
end

Then /I should see all of the movies/ do    # checa se a pagina tem o numero de table rows igual a contagem da tabela a cima
    if page.respond_to? :should
      page.should has_css("table#movies tbody tr", :count => @linhas_totais)
    else
      assert page.has_css?("table#movies tbody tr", :count => @linhas_totais)
    end
end

When /I check all ratings/ do # o mesmo que o "I should see all of the movies", pois o comportamento é o mesmo
    if page.respond_to? :should
        page.should has_css("table#movies tbody tr", :count => @linhas_totais)
    else
        assert page.has_css?("table#movies tbody tr", :count => @linhas_totais)
    end
end

Then /I should see "(.*)" before "(.*)"/ do |first, second|
    first = page.body.index(first)      # pega o index do primeiro filme no body recebido
    second = page.body.index(second)    # pega o index do segundo filme no body recebido

    assert(first < second)              # checa se o primeiro tem um indice menor que                                   
end                                     # o segundo e portanto vem antes