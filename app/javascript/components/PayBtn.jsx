import React from 'react';
import {loadStripe} from '@stripe/stripe-js';

const stripePromise = loadStripe('pk_test_vAZ3gh1LcuM7fW4rKNvqafgB00DR9RKOjN');

export default () => {

  const handleClick = async (e) => {
    e.preventDefault();

    const stripe = await stripePromise;
    // Create a checkout session on the server
    const checkoutSession = await fetch('/api/v1/payments', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          // pass any data that helps construct the checkout session.
        }),
      })
      .then((response) => response.json())
      .catch((error) => {
        console.error('Error:', error);
      });

    // Redirect to Checkout on the client.
    const result = await stripe.redirectToCheckout({
      sessionId: checkoutSession.id,
    });
  }

  return (
    <button onClick={handleClick}>Pay</button>
  )
}
