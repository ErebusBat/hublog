+++
Tags = ["mysql"]
date = "2015-07-02T14:49:48-06:00"
title = "MySQL Delete with JOIN and alias"
+++

Delete from an aliased table with a join.  Just make sure to use the table 
alias after the delete statement: `DELETE c`
<!--more-->

This will delete any customers who do not have both a `User` and `Draw` record
~~~ sql
DELETE C
FROM customers C
    LEFT OUTER JOIN users U ON C.number=U.customer_number
WHERE C.number NOT IN (
    SELECT DISTINCT customer_number FROM customer_draws WHERE customer_number IS NOT NULL
)
AND U.id IS NULL;
~~~

It can be simplified by using another `OUTER` join:
~~~ sql
DELETE C
FROM customers C
    LEFT OUTER JOIN users U ON C.number=U.customer_number
    LEFT OUTER JOIN customer_draws CD ON C.number=CD.customer_number
WHERE
    U.id IS NULL AND  -- No User Record
    CD.id IS NULL;    -- No Draw Record
~~~
