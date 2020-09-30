import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';

import 'bootstrap/dist/css/bootstrap.min.css';

import { HttpLink, ApolloLink, ApolloClient, InMemoryCache, ApolloProvider } from '@apollo/client';
import { onError } from "@apollo/client/link/error";

import ActionCable from 'actioncable';
import { ActionCableLink } from 'graphql-ruby-client';

const cable = ActionCable.createConsumer("ws://stl.me:3002/cable")

const httpLink = new HttpLink({
  uri: 'http://stl.me:3002/graphql'
  // credentials: 'included'
});

const hasSubscriptionOperation = ({ query: { definitions } }) => {
  return definitions.some(
    ({ kind, operation }) => kind === 'OperationDefinition' && operation === 'subscription'
  )
}

const link = ApolloLink.split(
  hasSubscriptionOperation,
  new ActionCableLink({ cable }),
  httpLink
);

const apolloClient = new ApolloClient({
  link: link,
  cache: new InMemoryCache()
});

ReactDOM.render(
  (<ApolloProvider client={apolloClient}>
    <React.StrictMode>
      <App />
    </React.StrictMode>
  </ApolloProvider>),
  document.getElementById('root') || document.createElement('div')
);

serviceWorker.unregister();

export { apolloClient };
