 with dane as( select A.dimension_1 as AD1,  map1.correct_dimension_2 as map1CD2, ISNULL(A.measure_1,0) as AM1, ISNULL(B.measure_2,0) as BM2,  B.dimension_1 as BD1, map2.correct_dimension_2 as map2CD2
  from A

join MAP map1 ON map1.dimension_1 = A.dimension_1
full outer join B ON A.dimension_1 = B.dimension_1
full outer join MAP map2 ON map2.dimension_1 = B.dimension_1
 where A.dimension_1 is not NULL OR B.dimension_1 is not NULL
 group by A.dimension_1, map1.correct_dimension_2, A.measure_1, B.measure_2, B.dimension_1, map2.correct_dimension_2
 )

 , dane2 as(
 Select BD1 as dimension_1, map2CD2 as dimension_2, AM1 as measure_1, BM2 as [measure_2]
 from dane
 where BD1 like 'd'
 )

 , dane3 as(
 Select AD1 as dimension_1, map1CD2 as dimension_2, AM1 as measure_1, BM2 as [measure_2]
 from dane
 where AD1 like 'a' or AD1 like 'b' or AD1 like 'c' 
 )

 select * from dane3
 UNION
 select * from dane2
