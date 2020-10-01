# scompler-test

## General usage
Open http://134.249.119.219:3003/ page to see main project test with already created atricles.

### Sort
Links on table headers are clickable and provides sort by columns. It works only on main articles table, and does not work for grouped representation.

Asnwer to my questions regards grouped representation was not fully clear, so decided to avoid additionall complexity with grouped tables search. 
In real app of cource everything claryifying untill understand what to do.

### Search
Search works together with search. Just put any title or article text that meet in a list and try to sort.
To clear search just put empty line.

### Grouping
As already mention done grouping as understood and showed possible combinations based on grouping settings placed on select box.

### MoDX
Decided to avoid using modx in advance to use useState hooks. Possible there some another strong sides to use ModX but for current prototype 
was enought to use build in react tools.

### Real time
I avoid to use any authorization for now, just open current website on another private tab and click on Generate Article button. 
New Article will appear on both tabs thanks to graphql subscriptions feature. 

### Tests
Each real app of course should be covered by tests, otherwise app will be very hard to maintain. Current prototype has good backend coverage at least 
all classes has unit tests and some partial frontend tests. Articles table component was covered by tests, other components was not as it is repeating 
work and takes more time. But I totally understand that can't be a case in real app.

### Optimization
Only base performance review was done. Some obvius thinks like N+1 was not fixed yet. Firdt rule of optimisation says: Don't do optimisation!

### Deployment
Currently project is running thanks docker swarm but real app should be improved to at least some kubernets solution there + 
jenkins to build and replace containers to achive 0 delay.
Also app updates without ^ approach treats by push to repository and pull it manually into the server.

