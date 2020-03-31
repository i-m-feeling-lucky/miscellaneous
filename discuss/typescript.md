关于 TypeScript 的事情，我看到上传了个人信息的人都一致写上了想用 TypeScript，但是“用过的...”里面没有 TypeScript，所以是都跟我一样之前没用过 TypeScript 么？🤣没有上传个人信息的有人之前用过么？

Vue 里面用 TypeScript 时会让你选择是否用 class-based API，下面的关于 class-based API 的例子，摘自 <https://vuejs.org/v2/guide/typescript.html>。

```vue
import Vue from 'vue'
import Component from 'vue-class-component'

// The @Component decorator indicates the class is a Vue component
@Component({
  // All component options are allowed in here
  template: '<button @click="onClick">Click!</button>'
})
export default class MyComponent extends Vue {
  // Initial data can be declared as instance properties
  message: string = 'Hello!'

  // Component methods can be declared as instance methods
  onClick (): void {
    window.alert(this.message)
  }
}
```

可以看到跟大家之前用的 object-based API 有很大不同：

```vue
<template>
  <FooBar />
</template>

<script>
import FooBar from './FooBar.vue';

export default {
  name: 'Foo',
  components: { FooBar },
  data() {
    return {
      message: ''
    };
  },
  methods: {
    hello() {
      ......
    },
  },
};
</script>
```

有意思的是，虽然目前使用 class-based API 是个默认选项，但是尤雨溪已经决定抛弃它，见 [[Abandoned] Class API proposal by yyx990803 · Pull Request #17 · vuejs/rfcs](https://github.com/vuejs/rfcs/pull/17#issuecomment-494242121)，而又提出了新的 API（composition functions），和 class-based API 一样，composition functions 也是多了一堆新的语法，不过它仍然兼容我们以前常用的 object-based API：

> Note the composition functions can be seen as a fully compatible extension on top of the 2.x object syntax - this means migration can be done progressively.

我的想法是，引入 TypeScript 只是为了通过 type 来减少 bug，（class-based API、composition functions 带来的）新语法是次要的，所以为了能更轻松地引入 TypeScript，我们在“Use class-based API”那个选项选择 No，但是也不使用 composition functions，而是仍然使用熟悉的 object-based API。

下面是没有用 TypeScript 的情况，和用了 TypeScript 但是没有用 class-based API 而是使用 object-based API 的情况的对比。

**不使用 TypeScript**

```vue
<template>
  <Preview />
</template>

<script>
import Preview from './Preview.vue';

export default {
  name: 'HomeBody',
  components: { Preview },
  data() {
    return {
      loadingPrompt: ''
    };
  },
  methods: {
    customAlert(message) {
      ......
    },
  },
};
</script>
```

**使用 TypeScript + 不使用 class-based API**

```vue
<template>
  <Preview />
</template>

<script lang="ts">
import Vue from 'vue';
import Preview from './Preview.vue';

export default Vue.extend({
  name: 'HomeBody',
  components: { Preview },
  data() {
    return {
      loadingPrompt: ''
    };
  },
  methods: {
    customAlert(message: string): void {
      ......
    },
  },
});
</script>

```
可以看到，迁移成本非常低，改动基本上只有：

1. `<script>` 到 `<script lang="ts">`；
2. 新加入 `import Vue from 'vue';`；
3. `export default {}` 到 `export default Vue.extend({ })`;
4. 引入了类型（如 methods 中函数的参数、返回值的类型）。

其中第 4 点正是我们引入 TypeScript 的直接目的。



综上我的想法是，新建 Vue.js 项目或者通过 `vue add typescript` 添加 TypeScript 时选择不使用 class-based API，之后在代码里也不使用  composition functions，而是沿袭我们熟悉的 object-based API，并加入少许修改（修改提示见上方对比）。



**参考**

1. https://github.com/vuejs/rfcs/pull/17
2. https://github.com/vuejs/rfcs/pull/42
3. https://github.com/vuejs/rfcs/blob/function-apis/active-rfcs/0000-function-api.md
4. <https://github.com/yusanshi/handwriting-go-away/blob/master/src/components/HomeBody.vue>（我尝试使用 TypeScript 的一个例子）

