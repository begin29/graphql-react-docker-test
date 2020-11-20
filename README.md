# Ruby + GraphQL + React with Appolo example and example how to have realtime update

That project was as a test work on some position, but it does not have some concrete right solutions
but possible will help someone to understand base graphQL structure, how it looks together with React
and Docker. And how to hanlde GraphQL subcriptions that provides for users real time updates. In case 
User has 2 tabs opens or 2 users looking on the same page.

There is one backend endpoint that understands how to sort, order, search by name and group by some article attributes.

Details about that actions can be found on rspec on backend side. Or run docker containeres with docker-compose up command and to check 
how it works together.

### Sort
Links on table headers are clickable and provide sort by columns. It works only on the main articles table and does not work for grouped representation.

### Search
Search works together with order. Put any title or article text that meets in a list and try to sort.
To clear search just put an empty line.

### Real time
I avoid using any authorization, for now, just open the current website on another private tab and click on the Generate Article button. 
New Article will appear on both tabs thanks to the graphql subscriptions feature. 

### Tests
The current prototype has good backend coverage at least all classes have unit tests and some partial frontend tests. Articles table component was covered by tests, other components were not as it is repeating work and takes more time.

### Optimization
The only base performance review was done. Some obvious thinks like N+1 were not fixed yet. First rule of optimization says: Don't do optimization!

### Deployment Process
Currently, the project is running thanks docker swarm but the real app should be improved to at least some Kubernetes solution there + 
Jenkins to build and replace containers to achieve 0 delays deploy.
Also, app updates without ^ approach treat by a push to the repository and pull it manually into the server.
