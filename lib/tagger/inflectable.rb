module Inflectable

  GRAM_CAT = { 
    #rzeczownik
    :adj => 'przymiotnik',
    [:subst,:depr] => 'rzeczownik',
    :adv => 'przyslowek',
    :num => 'liczebnik',
    [:pron,:siebie] => 'zaimek',
    :prep => 'przyimek',	
    #liczby
    :sg => 'liczba_pojedyncza', 
    :pl => 'liczba_mnoga', 

    #Przypadki
    :nom => 'mianownik',
    :gen => 'dopelniacz',
    :dat => 'celownik',
    :acc => 'biernik',
    :inst => 'narzednik',
    :loc => 'miejscownik',
    :voc => 'wolacz',

    #Rodzaje
    :m1 => 'meski_osobowy',
    :m2 => 'meski_zwierzecy',
    :m3 => 'meski_rzeczowy',
    :f => 'zenski',
    :n1 => 'nijaki_zbiorowy',
    :n2 => 'nijaki zwykly',
    :p1 => 'przymnogi_osobowy',
    :p2 => 'przymnogi_zwykly',
    :p3 => 'przymnogi_opisowy',

    #Osoby	
    :pri => "pierwsza_osoba",
    :sec => "druga_osoba",
    :ter => "trzecia_osoba",

    #Stopień
    :pos => "stopien_rowny",
    :comp => "stopien_wyzszy",
    :sup => "stopien_najwyzszy"
  }

  GRAM_CAT.each do |key,value|

    define_method(value+"?"){ 
      inflection.split(":").any?{|e| 
        if key.is_a? Array
          key.any?{|k| e.include? k.to_s}
        else 
          e.include? key.to_s 
        end
      }
    }
  end

end
