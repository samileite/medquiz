-- Migration: add question_type and correct_answers support

alter table questions
add column if not exists question_type text default 'single';

alter table questions
add column if not exists correct_answers text[] default '{}';

update questions
set correct_answers = array[correct_answer]
where correct_answer is not null
and (correct_answers is null or cardinality(correct_answers) = 0);

alter table user_answers
add column if not exists selected_answers text[] default '{}';

alter table user_answers
add column if not exists correct_answers text[] default '{}';

update user_answers
set selected_answers = array[selected_answer]
where selected_answer is not null
and (selected_answers is null or cardinality(selected_answers) = 0);

update user_answers
set correct_answers = array[correct_answer]
where correct_answer is not null
and (correct_answers is null or cardinality(correct_answers) = 0);
