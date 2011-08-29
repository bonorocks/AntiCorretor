require 'rubygems'  
require 'nokogiri'  
require 'open-uri'  

url = "http://www.wimoveis.com.br/df/brasilia/apartamento/venda/?bairro=asa-norte&busca=lista&quarto=1&palavra=314&o=F&planta=1&pronto=1"
doc = Nokogiri::HTML(open(url))  

  cidade = doc.css("html body form#aspnetForm div.cabecalho div.cabecalho_content h1 b").text
  cidade = cidade.slice(12..cidade.index(",")-1)
  doc.css(".listagem_item").each do |item|       
    local   = item.at_css(".localizacaoBairro").text.strip
    icones = item.search('td.icones')
    #.each { |e| puts e.text[/[0-9\.]+/]  }
    numqt = icones[0].text.strip
    numst = icones[1].text.strip
    numgar = icones[2].text.strip
    area   = item.at_css(".m2").text[/[0-9\.]+/] 
    valor  = item.at_css(".valores").text[/[0-9\.]+/]
    valm2 = item.at_css(".v_m2").text[/[0-9\.]+/]
    dat    = item.at_css(".atualizacao").text.strip  
    link    = item.css('.localizacaoBairro a').map { |link| link['href'] }
    cod   = link.to_s.slice(-6..-1)  
    puts "#{cidade} - #{local} - #{numqt} - #{numst} - #{numgar} - #{area} - #{valor} - #{valm2} - #{dat} - #{cod}"
   end  

