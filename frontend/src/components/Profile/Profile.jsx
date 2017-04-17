import React from 'react';
import './Profile.css';

export default function({ user }) {
  return (
    <section id='profile-container'>
      <img className='profile-avatar' src={user.avatar} />
      <h1 className='profile-name'>{user.username}</h1>
      <p className='profile-bio'>{user.bio}</p>
    </section>
  );
}


