require 'rubygems'  
require 'nokogiri'  
require 'open-uri'  

url = "http://www.wimoveis.com.br/df/brasilia/apartamento/venda/?bairro=asa-norte&busca=lista&quarto=1&o=F&pronto=1"
doc = Nokogiri::HTML(open(url))  

numpag = doc.css('.paginacao_texto span')[1].text.to_i 
num = 0

while num < numpag
    url = "http://www.wimoveis.com.br/df/brasilia/apartamento/venda/"+
    "?bairro=asa-norte&quarto=1&busca=lista&r=-1&s=0&o=F&pronto=1&pg=" + num.to_s

    doc = Nokogiri::HTML(open(url))  
    doc.css(".listagem_item").each do |item| 
      txt   = item.at_css(".localizacaoBairro").text
      txt2 = txt.gsub(/^ */,'').gsub(/ *$/,'')
      area   = item.at_css(".m2").text[/[0-9\.]+/] 
      valor  = item.at_css(".valores").text[/[0-9\.]+/]
      valm2 = item.at_css(".v_m2").text[/[0-9\.]+/]
      link    = item.css('.localizacaoBairro a').map { |link| link['href'] }
      cod   = link.to_s.slice(-6..-1)  
      puts "#{txt2} - #{area} - #{valor} - #{valm2} - #{cod}"
    end  
    num +=1
end