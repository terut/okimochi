import React from 'react';
import moment from 'moment';
import { setArticle, getCurrentArticle } from '../../actions';

import './Editor.css';

export default class Editor extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      originalBody: props.article ? props.article.body : '',
      editing: false,
      edited: false
    };
  }

  handleOnChange(e) {
    this.setState({
      edited: this.state.originalBody !== this.textInput.value
    });
  }

  componentWillReceiveProps(nextProps) {
    if (nextProps.article) {
      this.setState({
        originalBody: nextProps.article.body,
        editing: false,
        edited: false
      });
    }
    this.textInput.value = nextProps.article ? nextProps.article.body : '';
  }

  render() {
    const inited = this.props.article !== undefined;
    return (
      <div id='editor'>
        <h2 className='editor-h'>今日のお気持ち</h2>
        <div>
          <textarea
            id='editor-textarea'
            className={(this.state.editing || this.state.edited) ? 'editor-textarea-editing' : '' }
            ref={(tarea) => { this.textInput = tarea; }}
            onChange={e => { this.handleOnChange(e); }}
            onFocus={e => { this.setState({editing: true}); }}
            onBlur={e => { this.setState({editing: false}); }}
            disabled={!inited}
          />
        </div>
        {(this.state.editing || this.state.edited) &&
            <button
              id='editor-submit-btn'
              onClick={e => {
                this.props.onSubmit(this.textInput.value);
              }}
              disabled={!inited || !this.state.edited}
            >
              {this.props.article ? '更新' : '投稿'}
            </button>
        }
      </div>
    );
  }
}
