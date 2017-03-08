import React from 'react';
import './Profile.css';

export default function({ user }) {
    return (
      <div id='profile_box'>
        <img src={user.avatar} />
        <div>
          <div>{user.screen_name}</div>
          <div>{user.bio}</div>
        </div>
      </div>
    );
}


