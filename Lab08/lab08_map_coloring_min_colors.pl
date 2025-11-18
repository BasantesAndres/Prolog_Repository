%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LAB 08 - MAP COLORING + MIN COLORS
%% Stiudent: Andrés Basantes
%% Based on Lab 07 (Australia & South America)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- use_module(library(clpfd)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Color name mapping (codes 1 to 4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

color_names([
    1-red,
    2-green,
    3-blue,
    4-yellow
]).

print_region_color(ColorMap, Region, ColorCode) :-
    member(ColorCode-ColorName, ColorMap),
    format('~w = ~w~n', [Region, ColorName]).

pretty_color_by_region(Regions, Vars) :-
    color_names(ColorMap),
    maplist(print_region_color(ColorMap), Regions, Vars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Australia map: regions and edges
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

regions_au([wa, nt, sa, q, nsw, v, t]).

edges_au([
    wa-nt, wa-sa,
    nt-sa, nt-q,
    sa-q, sa-nsw, sa-v,
    q-nsw,
    nsw-v
]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% South America map: regions and edges
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Codes:
%% ar = Argentina, bo = Bolivia, br = Brazil, cl = Chile,
%% co = Colombia, ec = Ecuador, gy = Guyana,
%% gfr = French Guiana, py = Paraguay, pe = Peru,
%% su = Suriname, uy = Uruguay, ve = Venezuela

regions_sa([ar, bo, br, cl, co, ec, gy, gfr, py, pe, su, uy, ve]).

edges_sa([
    ar-bo, ar-br, ar-cl, ar-py, ar-uy,
    bo-br, bo-cl, bo-py, bo-pe,
    br-co, br-gy, br-pe, br-py, br-su, br-uy, br-ve,
    cl-pe,
    co-ec, co-pe, co-ve,
    ec-pe,
    gy-gfr, gy-su, gy-ve,
    gfr-su,
    py-br, py-ar,
    pe-bo, pe-br, pe-cl, pe-co, pe-ec,
    su-br, su-gy, su-gfr,
    uy-ar, uy-br,
    ve-br, ve-co, ve-gy
]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Core constraint model 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% constrain_edge(+Regions, +Vars, +A-B)
%% Ensure the colors of adjacent regions A and B are different.
constrain_edge(Regions, Vars, A-B) :-
    nth0(IndexA, Regions, A),
    nth0(IndexB, Regions, B),
    nth0(IndexA, Vars, ColorA),
    nth0(IndexB, Vars, ColorB),
    ColorA #\= ColorB.

%% map_color_general(+Regions, -Vars, +Edges, +K)
%% Create Vars, domain 1..K and post adjacency constraints.
map_color_general(Regions, Vars, Edges, K) :-
    same_length(Regions, Vars),
    Vars ins 1..K,
    maplist(constrain_edge(Regions, Vars), Edges).

%% color_map(+Regions, +Edges, +K, -Vars)
%% Wrapper: build constraints and run labeling (search).
color_map(Regions, Edges, K, Vars) :-
    map_color_general(Regions, Vars, Edges, K),
    labeling([ffc], Vars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Minimum number of colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% min_colors(+Regions, +Edges, +MaxK, -MinK, -Vars)
%% Try K = 1..MaxK and return the first K that works.
min_colors(Regions, Edges, MaxK, MinK, Vars) :-
    between(1, MaxK, K),
    color_map(Regions, Edges, K, Vars),
    MinK = K,
    !.  % cut: stop at the first successful K (minimum)

%% Convenience predicates for Australia and South America

min_colors_au(MaxK, MinK, Vars) :-
    regions_au(Regions),
    edges_au(Edges),
    min_colors(Regions, Edges, MaxK, MinK, Vars).

min_colors_sa(MaxK, MinK, Vars) :-
    regions_sa(Regions),
    edges_sa(Edges),
    min_colors(Regions, Edges, MaxK, MinK, Vars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% For pretty result
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% show_min_colors_au(+MaxK)
%% Example: ?- show_min_colors_au(4).
show_min_colors_au(MaxK) :-
    min_colors_au(MaxK, MinK, Vars),
    regions_au(Regions),
    format('Minimum colors for AUSTRALIA: ~w~n', [MinK]),
    pretty_color_by_region(Regions, Vars).

%% show_min_colors_sa(+MaxK)
%% Example: ?- show_min_colors_sa(6).
show_min_colors_sa(MaxK) :-
    min_colors_sa(MaxK, MinK, Vars),
    regions_sa(Regions),
    format('Minimum colors for SOUTH AMERICA: ~w~n', [MinK]),
    pretty_color_by_region(Regions, Vars).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Some example queries
%%
%% ?- min_colors_au(4, MinK, Vars).
%% ?- min_colors_sa(6, MinK, Vars).
%% ?- show_min_colors_au(4).
%% ?- show_min_colors_sa(6).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
