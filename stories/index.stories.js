import { storiesOf } from '@storybook/vue';
import { action } from '@storybook/addon-actions';
import { linkTo } from '@storybook/addon-links';

import Box from './Box'

storiesOf('Examples', module)
  .add('Basic', () => ({
    components: { Box },
    template: '<box @change="action"/>',
    methods: { action: action('clicked') },
  }));

// import MyButton from './MyButton';
// 
// 
// storiesOf('Button', module)
//   .add('with text', () => ({
//     components: { MyButton },
//     template: '<my-button @click="action">Hello Button</my-button>',
//     methods: { action: action('clicked') },
//   }))
//   .add('with JSX', () => ({
//     components: { MyButton },
//     // eslint-disable-next-line no-unused-vars
//     render(h) {
//       return <my-button onClick={this.action}>With JSX</my-button>;
//     },
//     methods: { action: linkTo('clicked') },
//   }))
//   .add('with some emoji', () => ({
//     components: { MyButton },
//     template: '<my-button @click="action">😀 😎 👍 💯</my-button>',
//     methods: { action: action('clicked') },
//   }));
// 
