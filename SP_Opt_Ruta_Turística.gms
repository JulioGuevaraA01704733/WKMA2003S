* ==================================================================
* =========== MODELO DE OPTIMIZACIÓN DE RUTAS TURISTICAS ===========
* ==================================================================

* PREPARACION DEL AMBIENTE
option optcr = 0.0001;

* PREPARAICON DEL MODELADO
set
*   Modificable: i /1*m/, m = cantidad de puntos de interes +1
    i /1*21/;
alias
    (i,j,k);
variable
    z,y;
Binary Variable 
    x(i,j);
scalar n;
    n = card(i);
sets
    dset1(i,j)
    dset2(i,j);
    dset1(i,j)=yes;
    dset1(i,i)=no;
    dset2(i,j)=yes;
    dset2(i,'1')=no;
    dset2('1',j)=no;
Table
*   Matriz de costos acarreados por todos los arcos. El primer y ultimo nodo DEBEN tener la misma información, DEBEN ser redundantes el uno del otro.
*   Modificable: Costo ≡ Distancia entre nodos
    c(i,j)
            1       2       3       4       5       6       7       8       9       10      11      12      13      14      15      16      17      18      19      20      21
    1       999     4.1     9.4     6.9     15.8    6.1     3.5     28      17.7    17      4       0.6     12.9    0.9     4.7     43.7    0.35    0.55    121     35.6    999
    2       4.4     999     7.5     9.5     17.5    8       5.5     29.7    20.4    10.6    4.1     4.2     15.9    4.5     9       47.4    4.2     4.7     124     30.9    4.4 
    3       9.6     7.5     999     14.8    22.8    14.2    5.7     21      28      12.8    9.9     8.9     18.2    10.1    14.2    52.6    10.1    9.9     129     34.9    9.6
    4       5.8     9.5     14.8    999     8.7     5.7     7.8     35.1    15.2    8.4     6.3     5.6     6.9     6.3     4.1     38      6.2     6.2     115     39      5.8    
    5       14.3    17.5    22.8    8.7     999     15.8    15.8    46.2    24      14.3    15.3    18.3    8.4     19      11.3    31.5    18.9    14.2    123     46.6    14.3
    6       9.2     8       14.2    5.7     15.8    999     10.9    34.3    14.5    13.7    5.5     5       12.1    5.7     5.2     43.6    5.6     5.6     120     34      9.2     
    7       5.9     5.5     5.7     7.8     15.8    10.9    999     28.9    20.7    8.1     3.6     3.9     11.6    6.2     11.5    44.8    5.8     5.3     125     37      5.9
    8       30.5    29.7    21      35.1    46.2    34.3    28.9    999     48      24.5    30.8    30.4    42      30.4    34.6    60.7    30.4    30.3    148     60.1    30.5
    9       18.6    20.4    28      15.2    24      14.5    20.7    48      999     22.8    17.2    17.4    21.5    18.1    17.6    53.1    18      17.9    129     47.3    18.6   
    10      7.7     10.6    12.8    8.4     14.3    13.7    8.1     24.5    22.8    999     8.2     6.7     5.7     7.9     10.7    37.7    7.5     8.1     125     41      7.7               
    11      0.5     4.1     11.2    6.3     15.3    5.5     3.6     30.8    37.2    8.2     999     0.35    12.7    0.35    5.8     44.2    0.9     0.75    121     34.5    0.5    
    12      0.17    4.1     10.6    6.3     15.2    5.5     3.5     30.8    17.2    13.2    0.75    999     12.7    0.3     5.8     44.2    0.8     0.75    121     34.5    0.17
    13      12.1    14.5    18      7       10      12.3    15.3    37.2    21.4    6.7     12.5    10.1    999     12.7    9.3     33.6    12.5    12.5    123     44.9    12.1
    14      0.9     3.7     10.2    9.2     15.7    5.9     3.2     30.4    17.6    12.8    0.4     0.75    15.5    999     8.7     39      1.3     0.4     124     34.1    0.9
    15      5.2     8.8     15.3    3.2     12.4    5.4     8.2     35.5    16      11.2    5.5     4.9     9.8     5.6     999     40      5.6     5.5     118     38.3    5.2
    16      55.3    65.7    65.6    50.7    30.3    55.4    58.5    59.5    60.3    56.8    55.7    55.2    34.1    55.9    45.8    999     56.7    55.7    118     88      55.3
    17      0.55    4.1     9.4     6.4     15.3    5.5     3.6     30.8    17.2    13.2    0.8     0.054   12.7    0.4     5.9     44.3    999     0.8     121     34.5    0.55
    18      1.3     3.5     8.9     7.1     16      6.3     3       30.4    17.9    12.7    0.7     0.8     15.4    1.1     4.9     46.9    0.75    999     123     34      1.3
    19      121     124     130     116     125     121     124     152     126     127     122     121     79.9    122     121     119     121     121     999     48.8    121
    20      35.6    32.3    35.6    39.5    48.5    34.7    34.9    63      47.7    43.3    39.9    35.4    45.9    36.1    39      77.4    35.3    35.9    154     999     35.6
    21      999     4.1     9.4     6.9     15.8    6.1     3.5     28      17.7    17      4       0.6     12.9    0.9     4.7     43.7    0.35    0.55    121     35.6    999;
Parameter
*   El primer elemento DEBE tener un valor de 1 y el último DEBE tener uno de -1.
    b(i)/
    1   1
    2   0
    3   0
    4   0
    5   0
    6   0
    7   0
    8   0
    9   0
    10  0
    11  0
    12  0
    13  0
    14  0
    15  0
    16  0
    17  0
    18  0
    19  0
    20  0
    21  -1/;

* PLANTEAMIENTO DEL MODELO
Equations
    obj
    r1
    r2
    r3
    r4
    r5
    r6
    r7;
    
*   Funcion objetivo: maximizar nodos a visitar.
    obj.. z =E= sum((i,j), x(i,j))-1;

*   Restricción de límite superior del costo incurrido por el viaje total
*   Modificable: r1.. (...) =l= p, p = presupuesto máximo
    r1.. sum((i,j), x(i,j)*c(i,j)) =l= 1.65;
*   Restricciones de regulación de flujo.
    r2(i).. sum(j, x(i,j)) - sum(k, x(k,i)) =E= b(i);
    r3(i).. sum(j, x(i,j)) =l= 1;
    r4(j).. sum(i, x(i,j)) =l= 1;
    r5(dset2(i,j)).. y(i)-y(j)+n*x(i,j)=l=n-1;
*   Restricción de selección de puntos de interés especificos a visitar.
*   Modificable & Replicable: r6.. sum(i, x(i,"J")) =e= 1;, J = índice del punto de interes a visitar.
    r6.. sum(i, x(i,"14")) =e= 1;
    r7.. sum(i, x(i,"11")) =e= 1;


* RESOLUCIÓN DEL MODELO
model costemin /all/;
solve costemin using MIP max z;
