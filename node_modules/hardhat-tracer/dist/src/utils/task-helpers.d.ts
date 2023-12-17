import { ConfigurableTaskDefinition, HardhatRuntimeEnvironment } from "hardhat/types";
export declare function registerTask(taskName: string): ConfigurableTaskDefinition;
export declare function addCliParams(_task: ConfigurableTaskDefinition): ConfigurableTaskDefinition;
export declare function applyCliArgsToTracer(args: any, hre: HardhatRuntimeEnvironment): void;
//# sourceMappingURL=task-helpers.d.ts.map