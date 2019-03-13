```
In order to use public transport
As a customer
I want money on my card
```

Object | Messages
---------------- | --------------------
Customer | 
Card | add_money

card = Oystercard.new
=> balance = £0
card.add_money(10)
=> balance = £10


```
In order to keep using public transport
As a customer
I want to add money to my card
```

Object | Messages
---------------- | --------------------
Customer | 
Card | top_up

card = Oystercard.new
=> balance = £0
card.top_up(10)
=> balance = £10

1. value of new card = £0
2. user adds £10
3. card balance = £10 
4. user chooses amount to add
5. balance += amount 

```
In order to protect my money from theft or loss
As a customer
I want a maximum limit (of £90) on my card
```

1. set max limit to 90
2. raise_error if max limit breached
3. set constant for the default limit

```
2.5.0 :001 > c = Oystercard.new
 => #<Oystercard:0x00007fd2b31ae4a0 @balance=0> 
2.5.0 :002 > c.top_up(15)
 => 15 
2.5.0 :003 > c.top_up(90)
 => 105    <- should raise error here with limit of 90
```

``` 
In order to pay for my journey
As a customer
I need my fare deducted from my card
```

Object | Messages
---------------- | --------------------
Customer | 
Card | top_up 
Card | deduct

```
2.5.0 :001 > c = Oystercard.new
 => #<Oystercard:0x00007fba70982858 @balance=0> 
2.5.0 :002 > c.top_up(50)
 => 50 
2.5.0 :003 > c.deduct(10)
Traceback (most recent call last):
        2: from /Users/mattthompson/.rvm/rubies/ruby-2.5.0/bin/irb:11:in `<main>'
        1: from (irb):3
NoMethodError (undefined method `deduct' for #<Oystercard:0x00007fba70982858 @balance=50>)
```

1. method for deduct
2. balance -= deduct

```
In order to get through the barriers.
As a customer
I need to touch in and out.
```

Object | Messages
---------------- | --------------------
Customer | 
Card | top_up 
Card | deduct
Card | in_journey?
Card | touch_in
Card | touch_out

```
2.5.0 :001 > c = Oystercard.new
 => #<Oystercard:0x00007fce72881998 @balance=0> 
2.5.0 :002 > c.top_up(25)
 => 25 
2.5.0 :003 > c.touch_in
Traceback (most recent call last):
        2: from /Users/mattthompson/.rvm/rubies/ruby-2.5.0/bin/irb:11:in `<main>'
        1: from (irb):6
NoMethodError (undefined method `touch_in' for #<Oystercard:0x00007fce72881998 @balance=10>)
```

1. in_journey? predicate (true/false?)
2. `touch_in` sets `in_journey?` to `true`
3. `touch_out` sets `in_journey?` to `false`

```
In order to pay for my journey
As a customer
I need to have the minimum amount (£1) for a single journey.
```

Object | Messages
---------------- | --------------------
Customer | 
Card | top_up 
Card | deduct
Card | in_journey?
Card | touch_in
Card | touch_out

```
2.5.0 :001 > c = Oystercard.new
 => #<Oystercard:0x00007f902c8d9870 @balance=0, @in_use=false>  
2.5.0 :004 > c.touch_in
 => true         <- should raise an error for a minimum amount of £1 to touch in 
```

1. set MINIMUM constant 
2. check balance against minimum when you check in 
3. raise error if balance < minimum 


```
In order to pay for my journey
As a customer
When my journey is complete, I need the correct amount deducted from my card
```

Object | Messages
---------------- | --------------------
Customer | 
Card | top_up 
Card | deduct
Card | in_journey?
Card | touch_in
Card | touch_out

```
2.5.0 :001 > c = Oystercard.new
 => #<Oystercard:0x00007fa290106398 @balance=0, @in_use=false> 
2.5.0 :002 > c.top_up(10)
 => 10 
2.5.0 :003 > c
 => #<Oystercard:0x00007fa290106398 @balance=10, @in_use=false> 
2.5.0 :004 > c.touch_in
 => true 
2.5.0 :005 > c
 => #<Oystercard:0x00007fa290106398 @balance=10, @in_use=true> 
2.5.0 :006 > c.touch_out
 => false 
2.5.0 :007 > c
 => #<Oystercard:0x00007fa290106398 @balance=10, @in_use=false>  <- balance should have changed by journey charge amount
```

```
In order to pay for my journey
As a customer
I need to know where I've travelled from
```

Object | Messages
---------------- | --------------------
Customer | 
Card | top_up 
Card | deduct (private now)
Card | in_journey?
Card | touch_in
Card | touch_out
Card | record_entry_station

2.5.0 :001 > c = Oystercard.new
 => #<Oystercard:0x00007fc7db012480 @balance=0, @in_use=false> 
2.5.0 :002 > c.top_up(5)
 => 5 
2.5.0 :003 > c.touch_in
 => true 
2.5.0 :004 > c
 => #<Oystercard:0x00007fc7db012480 @balance=5, @in_use=true> <- expect recorded entry station

```
In order to know where I have been
As a customer
I want to see all my previous trips
```

Object | Messages
---------------- | --------------------
Customer | 
Card | top_up 
Card | deduct (private now)
Card | in_journey?
Card | touch_in
Card | touch_out
Card | record_entry_station
Card | record_trip

1. record exit station
2. record entry and exit station as a single trip
3. store trip
4. set exit station back to nil

```
2.5.0 :001 > c = Oystercard.new
 => #<Oystercard:0x00007f8c6f0d9dc0 @balance=0> 
2.5.0 :002 > c.top_up(10)
 => 10 
2.5.0 :003 > c.touch_in("Angel")
 => "Angel" 
2.5.0 :004 > c.touch_out("Kilburn")

desired -> # => trip = [["Angel", "Kilburn"]]
```

```
In order to know how far I have travelled
As a customer
I want to know what zone a station is in
```

```
2.5.0 :001 > station = Station.new
2.5.0 :002 > station.zone
 => 6
```