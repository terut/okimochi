import React from 'react';
import { initBoard, postArticle, editArticle } from '../../actions';

import { Link } from 'react-router'
import './Board.css';
import Article from '../../components/Article/Article.jsx';
import Editor from '../../components/Editor/Editor.jsx';
import { connect } from 'react-redux';

class Board extends React.Component {
  componentDidMount() {
    initBoard(this.props.dispatch);
  }

  handleEditorSubmit(body) {
    if (this.props.article) {
      editArticle(this.props.article.id, body, this.props.dispatch);
    } else {
      postArticle(body, this.props.dispatch);
    }
  }

  render() {
    return (
      <div id='board-container'>
        <Editor
          article={this.props.article}
          onSubmit={body => this.handleEditorSubmit(body)}
        />
        <div id='board'>
          {this.props.users.map((user, i) => {
            return (
              <Link
                to={`/users/${user.id}?date=${user.current_article.published_on}`}
                className='board_block'
                key={i}>
                <Article
                  article={user.current_article}
                  user={user}
                  sticky={true}
                />
              </Link>
            );
          })}
        </div>
      </div>
    );
  }
};

export default connect(
  state => {
    return state.boards;
  }
)(Board);

