/* morfeusz.h
   Copyright (c) by Marcin Woliñski 
   $Date: 2006/06/04 21:14:38 $

   C language interface for Morfeusz morphological analyser

*/

#ifndef __MORFEUSZ_H__
#define __MORFEUSZ_H__

#ifndef __WIN32
#define DLLIMPORT
#else
/* A Windows system.  Need to define DLLIMPORT. */
#if BUILDING_MORFEUSZ
#  define DLLIMPORT __declspec (dllexport)
#else
#  define DLLIMPORT __declspec (dllimport)
#endif
#endif

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */


  /* Returns a string containing information on authors and version of
     the library:
  */

  DLLIMPORT char *morfeusz_about();



  /* 
     The result of analysis is  a directed acyclic graph with numbered
     nodes representing positions  in text (points _between_ segments)
     and edges representing interpretations of segments that span from
     one node to another.  E.g.,

         {0,1,"ja","ja","ppron12:sg:nom:m1.m2.m3.f.n1.n2:pri"}
         |
         |      {1,2,"zosta³","zostaæ","praet:sg:m1.m2.m3:perf"}
         |      |
       __|  ____|   __{2,3,"em","byæ","aglt:sg:pri:imperf:wok"}
      /  \ /     \ / \
     * Ja * zosta³*em *
     0    1       2   3

     Note that the word 'zosta³em' got broken into 2 separate segments.

     The structure below describes one edge of this DAG:

  */

  struct _InterpMorf {
    int p, k; /* number of start node and end node */
    char *forma, /* segment (token) */
      *haslo, /* lemma */
      *interp; /* morphosyntactic tag */
  };
  typedef struct _InterpMorf InterpMorf;



  /* Analyse a piece of text:

     'tekst' - the string to be analysed.  It should neither start nor
     end  within a  word.   Morfeusz has  limited  space for  results.
     Don't pass  to this function more  than a typical  paragraph at a
     time.  The best  strategy is probably to pass  to Morfeusz either
     separate words or lines of text.

     RETURNS a  table of  InterpMorf structures representing  edges of
     the  resulting  graph.   The   result  remains  valid  till  next
     invocation of morfeusz_analyse().  The function does not allocate
     any memory, the space is reused on subsequent invocations.

     The  starting node  of resulting  graph has  value of  0  on each
     invocation.  The end of results is marked with a sentinel element
     having the value -1 in the 'p' field.  If a segment is unknown to
     Morfeusz,  the  'haslo'  and  'interp' fields  in  the  resulting
     structure are NULL.
  */

  DLLIMPORT InterpMorf *morfeusz_analyse(char *tekst);

  /*
    Set options:

    'option' is set to  'value'.  Available options are represented by
    #defines listed below.

    RETURNS 1 (true) on success,  0 (false) on failure (no such option
    or value).
   */

  DLLIMPORT int morfeusz_set_option(int option, int value);

  /* 
     MORFOPT_ENCODING:
     
     The encoding  used for  'tekst' argument of  morfeusz_analyse and
     fields  'forma',  'haslo',  and  'interp' of  results.   Possible
     values: UTF-8, ISO-8859-2 (default), CP1250, CP852.
  */

#define MORFOPT_ENCODING 1

#define MORFEUSZ_UTF_8      8
#define MORFEUSZ_ISO8859_2  88592
#define MORFEUSZ_CP1250     1250
#define MORFEUSZ_CP852      852

#ifdef __cplusplus
} /* extern C */
#endif /* __cplusplus */

#endif /* __MORFEUSZ_H__ */
