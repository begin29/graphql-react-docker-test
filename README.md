# scompler-test

## General usage
Open http://134.249.119.219:3003/ page to see the main project test with already created articles.

### Sort
Links on table headers are clickable and provide sort by columns. It works only on the main articles table and does not work for grouped representation.

The answer to my questions regards grouped representation was not fully clear, so decided to avoid additional complexity with grouped tables search. 
In the real app of course everything clarifying until understanding what to do.

### Search
The search works together with the search. Just put any title or article text that meets in a list and try to sort.
To clear search just put an empty line.

### Grouping
As already mention done grouping as understood and showed possible combinations based on grouping settings placed on select box.

### MODx
Decided to avoid using MODx in advance to use useState hooks. Possible there some another strong side to use ModX but for the current prototype 
was enough to use build-in react tools.

### Real time
I avoid using any authorization, for now, just open the current website on another private tab and click on the Generate Article button. 
New Article will appear on both tabs thanks to the graphql subscriptions feature. 

### Tests
Each real app of course should be covered by tests, otherwise the app will be very hard to maintain. The current prototype has good backend coverage at least all classes have unit tests and some partial frontend tests. Articles table component was covered by tests, other components were not as it is repeating work and takes more time. But I understand that can't be the case in the real app.

### Optimization
The only base performance review was done. Some obvious thinks like N+1 were not fixed yet. First rule of optimization says: Don't do optimization!

### Deployment Process
Currently, the project is running thanks docker swarm but the real app should be improved to at least some Kubernetes solution there + 
Jenkins to build and replace containers to achieve 0 delays deploy.
Also, app updates without ^ approach treat by a push to the repository and pull it manually into the server.
