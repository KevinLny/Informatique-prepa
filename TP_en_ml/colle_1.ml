
let rec f l = 
  match l with
  | [] -> []
  | _::t -> l::f 
  
let rec max_liste lst =
  match lst with
  |[] -> 0
  |[x] -> x
  |h1::h2::t -> if h1>= h2 then max_liste (h1::t) else max_liste (h2::t)

let rec max_second lst = 
  match lst with
  |[] -> 0
  |[x] -> x
  |h1::h2::[] -> if h1 >= h2 then h2 else h1
  |h1::h2::h3::t -> if (h1<= h2) && (h1<=h3) then max_second(h2::h3::t) 
                    else if (h2<=h1) && (h2<=h3) then max_second(h1::h3::t)
                    else max_second(h1::h2::t)