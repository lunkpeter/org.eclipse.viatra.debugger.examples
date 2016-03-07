package org.eclipse.incquery.examples.cps.viatradebugger.performance

import org.eclipse.incquery.examples.cps.viatradebugger.performance.util.BasePerformanceTransformation
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutor
import org.eclipse.viatra.transformation.debug.adapter.impl.AdaptableExecutorFactory
import org.eclipse.viatra.transformation.evm.api.ExecutionSchema
import org.eclipse.viatra.transformation.runtime.emf.transformation.eventdriven.ExecutionSchemaBuilder

class PerformanceAdaptableExecutorTransformation extends BasePerformanceTransformation{
	extension AdaptableExecutorFactory factory = new AdaptableExecutorFactory();
	
	override ExecutionSchema createExecutionSchema(){	
		val executor = createAdaptableExecutor()
			.setQueryEngine(engine).build() as AdaptableExecutor
		
		val ExecutionSchemaBuilder builder= new ExecutionSchemaBuilder()
			.setEngine(engine)
			.setExecutor(executor)
			.setConflictResolver(createConflictResolver)

		return builder.build()
	}
}