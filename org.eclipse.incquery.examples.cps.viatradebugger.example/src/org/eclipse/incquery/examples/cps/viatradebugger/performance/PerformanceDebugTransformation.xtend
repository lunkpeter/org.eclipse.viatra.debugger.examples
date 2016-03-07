package org.eclipse.incquery.examples.cps.viatradebugger.performance

import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.BasePerformanceTransformation
import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.PerformanceTestDebuggerUI
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.transformation.debug.breakpoints.impl.TransformationBreakpoint
import org.eclipse.viatra.transformation.debug.configuration.TransformationDebuggerConfiguration
import org.eclipse.viatra.transformation.evm.api.ExecutionSchema
import org.eclipse.viatra.transformation.runtime.emf.transformation.eventdriven.ExecutionSchemaBuilder

class PerformanceDebugTransformation extends BasePerformanceTransformation{
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	
	override ExecutionSchema createExecutionSchema(){
		val debugAdapterConfiguration = new TransformationDebuggerConfiguration(
                new PerformanceTestDebuggerUI(),
                new TransformationBreakpoint(ruleProvider.hostRule.ruleSpecification),
                new TransformationBreakpoint(ruleProvider.applicationRule.ruleSpecification),
                new TransformationBreakpoint(ruleProvider.stateMachineRule.ruleSpecification),
                new TransformationBreakpoint(ruleProvider.stateRule.ruleSpecification),
                new TransformationBreakpoint(ruleProvider.transitionRule.ruleSpecification),
                new TransformationBreakpoint(ruleProvider.triggerRule.ruleSpecification)	
        );
		
		val executor = createAdaptableExecutor()
			.setQueryEngine(engine)
			.addConfiguration(debugAdapterConfiguration).build() as AdaptableExecutor
		
		val ExecutionSchemaBuilder builder= new ExecutionSchemaBuilder()
			.setEngine(engine)
			.setExecutor(executor)
			.setConflictResolver(createConflictResolver)

		return builder.build()
	}
}