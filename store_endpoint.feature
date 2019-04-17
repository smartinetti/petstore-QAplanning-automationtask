Feature: Store endpoint


Scenario: Pet inventories by status
Given the following pet statuses by quantity in the store:
	|status	|quantity	|
	|0		|3			|
	|1		|1			|
	|2		|1			|
When call a "GET" "/store/inventory"
Then response "200 successful operation"
And return a map with:
	|status	|quantity	|
	|0		|3			|
	|1		|1			|
	|2		|1			|
	
	
Scenario: Place an order for a pet in the store
Given logged user 
And pet status 'available'
When call a "POST" "/store/order" with body:
	{
		"id": 0,
		"petId": 0,
		"quantity": 1,
		"shipDate": "2019-04-17T21:20:19.460Z",
		"status": "placed",
		"complete": false
	}
Then response "200 successful operation"


Scenario: Place an order for a pet in the store - invalid order
Given logged user 
And pet status 'sold'
When call a "POST" "/store/order" with body:
	{
		"id": 0,
		"petId": 1,
		"quantity": 1,
		"shipDate": "2019-04-17T21:20:19.460Z",
		"status": "unknown",
		"complete": false
	}
Then response "400 invalid order"


Scenario: Find purchase order by id
Given order "1" is purchased
When call a "GET" "/store/order/1"
Then response "200 successful operation"


Scenario: Find purchase order by id - invalid id 
Given order "1" is purchased
When call a "GET" "/store/order/11"
Then response "400 invalid id supplied"


Scenario: Find purchase order by id - order not found
Given order is not purchased
When call a "GET" "/store/order/1"
Then response "404 order not found"


Scenario: Delete purchase order by id
Given order "1" is purchased
When call a "DELETE" "/store/order/1"
Then response "200 successful"


Scenario: Delete purchase order by id - invalid id
Given order "1" is purchased
When call a "DELETE" "/store/order/-1"
Then response "400 invalid id supplied"


Scenario: Delete purchase order by id - order not found
Given order is not purchased
When call a "DELETE" "/store/order/1"
Then response "404 order not found"


