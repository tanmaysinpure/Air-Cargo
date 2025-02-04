#1. Total Number of Unique Customers
#Question: How many unique customers are present in the system?
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customer;



#2. Most Popular Flight Route
#Question: Which flight route has the highest number of passengers?
select routes.origin_airport,routes.destination_airport,count(passengers_on_flights.customer_id) as total_passenger
from passengers_on_flights
join routes
on
routes.route_id = passengers_on_flights.route_id
group by routes.origin_airport,routes.destination_airport
order by total_passenger desc
limit 3;

#3. Revenue per Flight Route
#Question: What is the total revenue generated from ticket sales for each flight route?
SELECT r.origin_airport, r.destination_airport, SUM(td.Price_per_ticket * td.no_of_tickets) AS total_revenue
FROM ticket_details td
JOIN routes r ON td.aircraft_id = r.aircraft_id
GROUP BY r.origin_airport, r.destination_airport
ORDER BY total_revenue DESC;


#4. Average Ticket Price per Route
#Question: What is the average ticket price for each flight route?
SELECT r.origin_airport, r.destination_airport, AVG(td.Price_per_ticket) AS avg_ticket_price
FROM ticket_details td
JOIN routes r ON td.aircraft_id = r.aircraft_id
GROUP BY r.origin_airport, r.destination_airport;


#5. Top 10 Customers by Number of Tickets Purchased
#Question: Which customers have purchased the most tickets overall?
SELECT c.first_name, c.last_name, SUM(td.no_of_tickets) AS total_tickets
FROM customer c
JOIN ticket_details td ON c.customer_id = td.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_tickets DESC
LIMIT 10;

#6. Revenue Generated per Customer
#Question: What is the total revenue generated from each customer?
SELECT c.first_name, c.last_name, SUM(td.Price_per_ticket * td.no_of_tickets) AS total_revenue
FROM customer c
JOIN ticket_details td ON c.customer_id = td.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue DESC;

#7. Seat Class Preferences
#Question: What is the distribution of seat classes chosen by passengers (economy, business, first class)?
SELECT pf.class_id, COUNT(pf.customer_id) AS total_passengers
FROM passengers_on_flights pf
GROUP BY pf.class_id;

#8. Most Frequent Flyers
#Question: Which customers have traveled the most on flights?
SELECT c.first_name, c.last_name, COUNT(pf.flight_num) AS total_flights
FROM customer c
JOIN passengers_on_flights pf ON c.customer_id = pf.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_flights DESC
LIMIT 10;


#9. Flight Occupancy by Route
#Question: What is the average flight occupancy (number of passengers) for each route?
SELECT r.origin_airport, r.destination_airport, COUNT(pf.customer_id) AS total_passengers
FROM passengers_on_flights pf
JOIN routes r ON pf.route_id = r.route_id
GROUP BY r.origin_airport, r.destination_airport;


#10. Revenue by Seat Class
#Question: How much revenue is generated from each seat class across all flights?
SELECT pf.class_id, SUM(td.Price_per_ticket * td.no_of_tickets) AS total_revenue
FROM passengers_on_flights pf
JOIN ticket_details td ON pf.customer_id = td.customer_id AND pf.aircraft_id = td.aircraft_id
GROUP BY pf.class_id;


#11. Flight Distance and Ticket Price Correlation
#Question: Is there a correlation between flight distance (in miles) and ticket price?
SELECT r.distance_miles, AVG(td.Price_per_ticket) AS avg_ticket_price
FROM ticket_details td
JOIN routes r ON td.aircraft_id = r.aircraft_id
GROUP BY r.distance_miles
ORDER BY r.distance_miles;


#13. Top 5 Routes by Revenue
#Question: Which 5 routes generate the highest revenue from ticket sales?
SELECT r.origin_airport, r.destination_airport, SUM(td.Price_per_ticket * td.no_of_tickets) AS total_revenue
FROM ticket_details td
JOIN routes r ON td.aircraft_id = r.aircraft_id
GROUP BY r.origin_airport, r.destination_airport
ORDER BY total_revenue DESC
LIMIT 5;


#14. Average Revenue per Flight
#Question: What is the average revenue generated per flight for each aircraft?
SELECT pf.aircraft_id, AVG(td.Price_per_ticket * td.no_of_tickets) AS avg_revenue
FROM passengers_on_flights pf
JOIN ticket_details td ON pf.customer_id = td.customer_id AND pf.aircraft_id = td.aircraft_id
GROUP BY pf.aircraft_id;


#15. Most Profitable Routes
#Question: Which routes are the most profitable based on the number of passengers and ticket prices?
SELECT r.origin_airport, r.destination_airport, SUM(td.Price_per_ticket * td.no_of_tickets) AS total_revenue, COUNT(pf.customer_id) AS total_passengers
FROM passengers_on_flights pf
JOIN ticket_details td ON pf.customer_id = td.customer_id AND pf.aircraft_id = td.aircraft_id
JOIN routes r ON pf.route_id = r.route_id
GROUP BY r.origin_airport, r.destination_airport
ORDER BY total_revenue DESC;








