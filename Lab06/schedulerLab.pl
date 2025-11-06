:- use_module(library(clpfd)).

task(a, 3, 1).  % Task 'a' takes 3 units, uses resource 1
task(b, 2, 1).  % Task 'b' takes 2 units, uses resource 1
task(c, 4, 2).  % Task 'c' takes 4 units, uses resource 2
task(d, 5, 2).  % Task 'd' takes 5 units, uses resource 2

% PRECEDENCE CONSTRAINTS


precedes(a, b).  % Task 'a' must complete before 'b' starts
precedes(c, d).  % Task 'c' must complete before 'd' starts


% MAIN SCHEDULER PREDICATE

schedule(TaskSchedules, Makespan) :-
    % Step 1: Collect all tasks
    findall(task(Name, Dur, Res), task(Name, Dur, Res), Tasks),
    
    % Step 2: Create decision variables (start times) for each task
    create_variables(Tasks, Starts, Ends, TaskSchedules),
    
    % Step 3: Apply temporal constraints (End = Start + Duration)
    apply_duration_constraints(TaskSchedules),
    
    % Step 4: Apply resource constraints (no overlap on same resource)
    apply_resource_constraints(TaskSchedules),
    
    % Step 5: Apply precedence constraints (dependencies)
    apply_precedence_constraints(TaskSchedules),
    
    % Step 6: Calculate makespan (project end time)
    calculate_makespan(Ends, Makespan),
    
    % Step 7: Solve with optimization (minimize makespan)
    labeling([min(Makespan)], Starts),
    
    % Step 8: Display results
    display_schedule(TaskSchedules, Makespan).



create_variables([], [], [], []).
create_variables([task(Name, Dur, Res)|Tasks], [Start|Starts], [End|Ends], 
                 [scheduled(Name, Dur, Res, Start, End)|Scheduled]) :-
    % Domain: start time can be from 0 to 100 (adjust if needed)
    Start in 0..100,
    End in 0..100,
    create_variables(Tasks, Starts, Ends, Scheduled).


% STEP 2: DURATION CONSTRAINTS


apply_duration_constraints([]).
apply_duration_constraints([scheduled(_, Dur, _, Start, End)|Rest]) :-
    End #= Start + Dur,  % Basic temporal constraint
    apply_duration_constraints(Rest).


% STEP 3: RESOURCE CONSTRAINTS

apply_resource_constraints(TaskSchedules) :-
    % Group tasks by resource
    findall(Res, task(_, _, Res), ResourcesList),
    list_to_set(ResourcesList, Resources),
    % Apply non-overlap constraint for each resource
    apply_resource_constraints_per_resource(Resources, TaskSchedules).

apply_resource_constraints_per_resource([], _).
apply_resource_constraints_per_resource([Res|Resources], TaskSchedules) :-
    % Get all tasks using this resource
    findall(task(Start, Dur, End, Res, _),
            (member(scheduled(_, Dur, Res, Start, End), TaskSchedules)),
            ResourceTasks),
    % Apply disjoint1 constraint (non-overlapping intervals)
    (ResourceTasks \= [] -> disjoint1(ResourceTasks); true),
    apply_resource_constraints_per_resource(Resources, TaskSchedules).


apply_precedence_constraints(TaskSchedules) :-
    findall(precedes(X, Y), precedes(X, Y), Precedences),
    apply_precedences(Precedences, TaskSchedules).

apply_precedences([], _).
apply_precedences([precedes(TaskX, TaskY)|Rest], TaskSchedules) :-
    % Find TaskX and TaskY in the schedule
    member(scheduled(TaskX, _, _, _, EndX), TaskSchedules),
    member(scheduled(TaskY, _, _, StartY, _), TaskSchedules),
    % Apply constraint: TaskX must finish before TaskY starts
    EndX #=< StartY,
    apply_precedences(Rest, TaskSchedules).


% STEP 5: CALCULATE MAKESPAN

calculate_makespan(Ends, Makespan) :-
    Makespan #= max(Ends).

% STEP 6: DISPLAY RESULTS


display_schedule(TaskSchedules, Makespan) :-
    nl,
    writeln('========================================'),
    writeln(' SCHEDULE'),
    writeln('========================================'),
    nl,
    format('~w~15|~w~25|~w~35|~w~n', ['Task', 'Start', 'End', 'Resource']),
    writeln('----------------------------------------'),
    print_tasks(TaskSchedules),
    nl,
    writeln('========================================'),
    format('  TOTAL MAKESPAN: ~w time units~n', [Makespan]),
    writeln('========================================'),
    nl.

print_tasks([]).
print_tasks([scheduled(Name, _, Res, Start, End)|Rest]) :-
    format('~w~15|~w~25|~w~35|~w~n', [Name, Start, End, Res]),
    print_tasks(Rest).


% ALTERNATIVE: SIMPLE SCHEDULE WITH FEWER TASKS


simple_schedule(Starts, Makespan) :-
    Starts = [S1, S2],
    S1 in 0..10,
    S2 in 0..10,
    
    % Task durations
    E1 #= S1 + 3,
    E2 #= S2 + 2,
    
    % Precedence: Task 1 before Task 2
    E1 #=< S2,
    
    % Makespan
    Makespan #= max(E1, E2),
    
    % Optimize
    labeling([min(Makespan)], Starts),
    
    % Display
    nl,
    format('Simple Schedule:~n'),
    format('Task 1: Start=~w, End=~w~n', [S1, E1]),
    format('Task 2: Start=~w, End=~w~n', [S2, E2]),
    format('Makespan: ~w~n', [Makespan]),
    nl.

