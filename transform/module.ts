/* eslint-disable @typescript-eslint/no-object-literal-type-assertion */
import * as ts from "typescript";
import {
  createBlock,
  createCallExpression,
  createExpressionStatement,
  createFunctionExpression,
  createIdentifier,
  createStringLiteral,
  Plugin,
} from "typescript-to-lua";
import { transformSourceFileNode } from "typescript-to-lua/dist/transformation/visitors/sourceFile";

export default {
  visitors: {
    [ts.SyntaxKind.SourceFile]: (node, context) => {
      const block = transformSourceFileNode(node, context);
      if (context.isModule) {
        const moduleFunction = createFunctionExpression(
          block,
          undefined,
          undefined,
          undefined
        );

        const moduleName = context.sourceFile.fileName
          .split("src")[1]
          .replace(/^\//, "") // remove leading slash
          .replace(/\.tsx?$/, "")
          .replace(/\//g, ".")
          .replace(/\.index$/, "");
        console.log(moduleName);

        if (moduleName === "init") return block;

        // tstl_register_module("module/name", function() ... end)
        const moduleCallExpression = createCallExpression(
          createIdentifier("tstl_register_module"),
          [createStringLiteral(moduleName), moduleFunction]
        );

        return createBlock([createExpressionStatement(moduleCallExpression)]);
      }
      return block;
    },
  },
} as Plugin;
