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
    numqt = icones[0].text.strip
    numqt = Integer(numqt)
    numst = icones[1].text.strip
    numst = Integer(numst)
    numgar = icones[2].text.strip
    numgar = Integer(numgar)
    area   = item.at_css(".m2").text[/[0-9\.]+/]
    area = Integer(area)
    valor  = item.at_css(".valores").text[/[0-9\.]+/]
    valor = Integer(valor.delete('.'))
    valm2 = item.at_css(".v_m2").text[/[0-9\.]+/]
    valm2 = Integer(valm2.delete('.'))
    dat    = item.at_css(".atualizacao").text.strip  
    link    = item.css('.localizacaoBairro a').map { |link| link['href'] }
    cod   = link.to_s.slice(-6..-1)  
    puts "#{cidade} - #{local} - #{numqt} - #{numst} - #{numgar} - #{area} - #{valor} - #{valm2} - #{dat} - #{cod}"
   end  

