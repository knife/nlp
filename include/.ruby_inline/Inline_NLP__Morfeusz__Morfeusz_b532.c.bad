#include "ruby.h"
#include "morfeusz.h"

# line 20 "/home/knife/.gem/ruby/1.8/gems/nlp-0.2.0/lib/morfeusz.rb"
static VALUE initialize(VALUE self) {

            morfeusz_set_option(1,8);
return Qnil;
}

# line 26 "/home/knife/.gem/ruby/1.8/gems/nlp-0.2.0/lib/morfeusz.rb"
static VALUE about(VALUE self) {

            return rb_str_new2(morfeusz_about());
          }


# line 32 "/home/knife/.gem/ruby/1.8/gems/nlp-0.2.0/lib/morfeusz.rb"
static VALUE _base(VALUE self, VALUE _str) {
  VALUE str = (_str);

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
            return (arr); 
          }



#ifdef __cplusplus
extern "C" {
#endif
  void Init_Inline_NLP__Morfeusz__Morfeusz_b532() {
    VALUE c = rb_cObject;
    c = rb_const_get(c, rb_intern("NLP"));
    c = rb_const_get(c, rb_intern("Morfeusz"));
    c = rb_const_get(c, rb_intern("Morfeusz"));

    rb_define_method(c, "_base", (VALUE(*)(ANYARGS))_base, 1);
    rb_define_method(c, "about", (VALUE(*)(ANYARGS))about, 0);
    rb_define_method(c, "initialize", (VALUE(*)(ANYARGS))initialize, 0);

  }
#ifdef __cplusplus
}
#endif
