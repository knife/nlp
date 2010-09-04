# Ruby bindings for Morfeusz v. 0.1
# Author: Aleksander Pohl
# apohllo@o2.pl 

require 'rubygems'
require 'inline'
require 'singleton'
require 'iconv'
module NLP
  module Morfeusz
    MORFOPT_ENCODING = 1
    MORFEUSZ_UTF_8 = 8
    class Morfeusz
      include Singleton

      inline(:C) do |builder|
        builder.include '"morfeusz.h"'
        builder.add_compile_flags '-lmorfeusz', '-I/home/knife/morf/include/'
        builder.c <<-END
          void initialize(){
            morfeusz_set_option(#{MORFOPT_ENCODING},#{MORFEUSZ_UTF_8});
          }
        END

        builder.c <<-END
          char * about(){
            return morfeusz_about();
          }
        END

        builder.c <<-END
          VALUE _base(VALUE str){
            char * p;
            int index = 0;
            VALUE arr = rb_ary_new();
            int id_push = rb_intern("push");
            p = StringValuePtr(str);
            InterpMorf* result = morfeusz_analyse(p);
              InterpMorf el;
              while((el = result[index++]).k != -1){
                if(el.haslo != NULL){
                  rb_funcall(arr,id_push,1,rb_str_new2(el.haslo));
                }
              }
            return arr; 
          }
        END

        def base(word)
#          _base(word)
          _base(word).collect{|e| e}
        end
       
      end
    end

    class Lexeme
      attr_reader :base_form
      def initialize(base_form)
        @base_form = base_form
      end

      def self.find(word)
        Morfeusz.instance.base(word).collect{|bf| Lexeme.new(bf)}
      end

    end
  end
end
