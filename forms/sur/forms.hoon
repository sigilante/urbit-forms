|%
::
::  Top Level
::
+$  metas        ((mop survey-id metadata) gth)
+$  content      ((mop survey-id questions) gth)
+$  pending      (set [author slug])
+$  slugs        (map slug survey-id)
+$  subscribers  (map survey-id ships)
+$  results      ((mop survey-id responses) gth)
::+$  access  (map survey-id [restriction=?(%black %white) =ships])
::
::  Main Types
::
+$  responses  ((mop response-id response) gth)
+$  response   [=author =answers]
+$  survey     [=metadata =questions]
+$  metadata   $:  =author       =status
                   =slug         =title
                   =description  =visibility
                   =spawn        =updated
                   =rlimit       =q-count
               ==
::
::  Basic Types
::
+$  survey-id    @ud
+$  response-id  ?(@ud %draft)
+$  ships        (set ship)
+$  author       ship
+$  slug         @ta
+$  title        @t
+$  description  @t
+$  visibility   ?(%public %private %team %restricted)
+$  spawn        @da
+$  updated      @da
+$  q-count      @ud
+$  rlimit       @ud
+$  status       ?(%archived %live)
::
::  Answers
::
+$  answers     ((mop question-id answer) lth)
+$  answer      $%  agrid
                    atext
                    alist
                ==
+$  agrid   [%grid (list [@t @t])]
+$  atext   [%text @t]
+$  alist   [%list (list @t)]
::
::  Questions
::
+$  questions    ((mop question-id question) lth)
+$  question-id  @ud
+$  question     [=qtitle =front =back =required x=(list @t) y=(list @t)]
+$  qtitle      @t
+$  required     ?
+$  front     $?
                %statement::
                %short::
                %long::
                %one::
                %many::
                %grid-one
                %grid-many
                %linear-discrete::
                %linear-continuous::
                %calendar
              ==
+$  back     $?  %text
                 %list
                 %grid
             ==
::
::  Actions
::
+$  action   $%  
               medit
               ask
               create
               qnew
               qedit
               qdel
               dedit
               submit
               delete
::               clone
             ==
+$  ask     [%ask =author =slug]
+$  medit   [%medit =survey-id =title =description =visibility =slug =rlimit]
+$  qnew    [%qnew =survey-id question]
+$  qdel    [%qdel =survey-id =question-id]
+$  qedit   [%qedit =survey-id =question-id =question]
+$  dedit   [%dedit =survey-id =question-id =answer]
+$  create  [%create =title =description =visibility =slug =rlimit]
+$  submit  [%submit =survey-id]
+$  delete  [%delete =survey-id]
::                 [%move-q old=question-id new=question-id]
+$  clone        $:  %clone
                     =status
                     =survey-id
                     =title
                     =description
                     =visibility
                     =slug
                     =rlimit
                 ==
::
::  Requests
::  
+$  request  $%  
               [%slug =slug]
               [%id =slug =survey-id]
               [%fail =slug]
               [%response =survey-id =response-id =answers]
             ==
::
::  Updates
::
+$  update   $% 
                [%init survey]
                [%metadata =metadata]
                [%questions =questions]
                [%survey survey]
             ==
+$  frontend  $%
                [%metas =metas]
                [%active =survey-id survey =answers]
                [%responses =responses]
              ==
--
