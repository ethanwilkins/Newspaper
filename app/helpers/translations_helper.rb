module TranslationsHelper
	def auto_translate text
		t = Translation
    if t.language(text).eql? :english and not english?
      t.translator.translate(text, :from => 'en', :to => 'es')
    elsif t.language(text).eql? :spanish and english?
      t.translator.translate(text, :from => 'es', :to => 'en')
    else
    	text
    end
	end
end
