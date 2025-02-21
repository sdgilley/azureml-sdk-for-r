% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute.R
\name{wait_for_provisioning_completion}
\alias{wait_for_provisioning_completion}
\title{Wait for a cluster to finish provisioning}
\usage{
wait_for_provisioning_completion(cluster, show_output = FALSE)
}
\arguments{
\item{cluster}{The \code{AmlCompute} or \code{AksCompute} object.}

\item{show_output}{If \code{TRUE}, more verbose output will be provided.}
}
\description{
Wait for a cluster to finish provisioning. Typically invoked after a
\code{create_aml_compute()} or \code{create_aks_compute()} call.
}
\section{Examples}{

Wait for an AmlCompute cluster to finish provisioning.\preformatted{ws <- load_workspace_from_config()
compute_target <- create_aml_compute(ws,
                                     cluster_name = 'mycluster',
                                     vm_size = 'STANDARD_D2_V2',
                                     max_nodes = 1)
wait_for_provisioning_completion(compute_target)
}
}

\seealso{
\code{create_aml_compute()}, \code{create_aks_compute()}
}
