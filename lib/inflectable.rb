module Inflectable
	
	GRAM_CAT = { 
		#rzeczownik
		[:subst, :depr] => 'rzeczownik',
		:adj => 'przymiotnik',
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
    		:m1 => 'męski_osobowy',
    		:m2 => 'męski_zwierzęcy',
    		:m3 => 'męski_rzeczowy',
    		:f => 'żeński',
    		:n1 => 'nijaki zbiorowy',
		:n2 => 'nijaki zwykły',
    		:p1 => 'przymnogi osobowy',
		:p2 => 'przymnogi zwykły',
		:p3 => 'przymnogi opisowy',
		
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
		if key.kind_of? Array
			key = key.first
		else
			define_method(value+"?"){ 
				inflection.split(":").any?{|e| e.include? key.to_s[1..-1]}
			}
		end
	      end


	
	       	
end
