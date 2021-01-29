;; Based on Uri Wilensky's Slime simulation (Netlogo's library model)

turtles-own[
  scout                ;;defines the "type" of nuclei
  energy               ;;simulates life
  neighbourhood        ;;defines the agent's neighbors within a radius
  paths-near            ;;defines the agent's path within a radius
  nearest-neighbor
]

breed [ nuclei nucleus ]
breed [ paths path ]

patches-own[
  oat                   ;;differentiate food-patches
  quantity              ;;simulates the food rest
  food-chemical         ;;simulates natural chemical segregation - by oats
  cohesion-chemical     ;;simulates cohesion method - by nuclei
  path-chemical         ;;simulates food communication method - by paths
  path?                 ;;differentiate path-patches
]

to setup
  clear-all
  create-nuclei nuclei-quantity
  [ set scout false
    set color red
    set size 2
    setxy 0 0  ]
  ask patches
  [ set oat false
    set path? false
    set food-chemical 0
    set cohesion-chemical 0 ]
  arrange-oats
  reset-ticks
end

to go
  ask nuclei [
    if scout = false [ turn-toward-chemical ]                               ;; cohere if not a scout
    wiggle
    explore-environment
    move
    set cohesion-chemical cohesion-chemical + 2                             ;; drop chemical onto patch
  ]

  diffuse cohesion-chemical 1                                               ;; diffuse chemical upon interaction
  diffuse path-chemical 1                                                   ;; diffuse chemical upon slime branches -> diffusion rate

  ask patches with [ oat = false ] 
  [ set cohesion-chemical cohesion-chemical * 0.9                           ;; evaporate chemical
    set pcolor scale-color orange cohesion-chemical 0.1 3 ]
  ask patches with [ path? = true ] 
  [ set path-chemical path-chemical * 0.9                                    ;; evaporate chemical
    if ticks mod 15 = 0 
    [ set path-chemical path-chemical + 2]
    set path-chemical path-chemical + 2
    set pcolor scale-color green path-chemical 0.1 4 ]
  tick
end

;initialize food areas
to arrange-oats
  ask n-of 6 patches [
    set oat true
    set quantity 100
  ]
  ask patches with [ oat = true ][
    ask patches in-radius 5 [
      set oat true
      set pcolor gray
      set quantity 100
    ]
  ]
end

to turn-toward-chemical  ;; turtle procedure
  ;; examine the patch ahead of you and two nearby patches;
  ;; turn in the direction of the strongest chemical
  if cohesion-chemical > sniff-threshold [                                     ;; ignore pheromone unless there's enough here
    let ahead [cohesion-chemical] of patch-ahead 1
    let myright [cohesion-chemical] of patch-right-and-ahead sniff-angle 1
    let myleft [cohesion-chemical] of patch-left-and-ahead sniff-angle 1
    ifelse (myright >= ahead) and (myright >= myleft)
    [
      rt sniff-angle
    ] [ if myleft >= ahead
      [ lt sniff-angle ]
    ]
  ]
    ;; default: don't turn
end

;; Define scouts ignoring cohesion chemical
to explore-environment ;; turtle procedure
  set neighbourhood other nuclei in-radius 2
  ifelse count neighbourhood < 4 [
    set scout true
    if [path?] of patch-here = false
    [ hatch-paths 1                                                             ;; construct the veins
      [ set shape "dot"
        set size 3
        set color yellow
        set path? true ]
    ]
  ] [ set scout false ]
end

to move ;; turtle procedure
  ifelse scout = true
  [
;    set paths-near other paths in-cone 5 60                                             ;; Avoid exploring the same paths -> (ortogonal repulsion)
;    if any? paths-near [ avoid-paths ]
    if [path?] of patch-ahead 5 = true [ avoid-paths ]
    set neighbourhood other nuclei in-radius 2.5
    if any? neighbourhood [
      find-nearest-neighbor
      if distance nearest-neighbor < avoidance-distance [ avoid-nuclei ]                ;; Avoid nuclei neighbors
    ]
    fd 1
  ] [ fd 1 ]
end

;; Random walk (exploration)
to wiggle ;; turtle procedure
  rt random-float wiggle-angle - random-float wiggle-angle
end

;;Find the closest neighbor within the neighbourhood
to find-nearest-neighbor
  set nearest-neighbor min-one-of neighbourhood [distance myself]
end

;; Avoid other nuclei
to avoid-nuclei ;; turtle procedure
  if nearest-neighbor != 0 [
    ask nearest-neighbor [ rt theta ]
  ]
end

;; Avoid constructed paths
to avoid-paths ;;trutle procedure
;  set heading heading - 90
  rt random 120
end

;----------------- Exploring the boid's technique -----------------------;

;;Prevent nucleis from colliding with their equals
to boid's-avoid  ;;turtle procedure
  turn-away ([heading] of nearest-neighbor) 3.0             ;; defined by the max-avoid-turn, degrees.
end


;;Change heading of turtle away from imminent collision
to turn-away [new-heading max-turn]  ;turtle procedure
  turn-at-most (subtract-headings heading new-heading) max-turn
end

;;Turn right if turn-degrees is positive, left otherwise.
;;Always limited by "max-turn".
to turn-at-most [turn-degrees max-turn]  ;turtle procedure
  ifelse abs turn-degrees > max-turn
    [ ifelse turn-degrees > 0
      [ rt max-turn ]
        [ lt max-turn ] ]
    [ rt turn-degrees ]
end

