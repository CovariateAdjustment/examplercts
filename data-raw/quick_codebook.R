quick_codebook <-
  function(x, exclude_listing = NULL, exclude = NULL){
    if(!inherits(x = x, what = "data.frame")){
      stop("x must be a data.frame.")
    }
    
    if(!is.null(exclude)){
      if(
        !all(
          inherits(x = exclude, what = "character"),
          length(exclude) > 0
        ) 
      ){
        stop("'exclude' must be character with positive length.")
      } else if(!all(exclude %in% colnames(x))){
        stop(
          "'exclude' must be column names in 'x': Columns \"",
          paste(setdiff(x = exclude, y = colnames(x)), collapse = "\", \""),
          "\" do not exist in 'x'."
        )
      } else {
        x[, exclude] <- NULL
      }
    }
    
    if(!is.null(exclude_listing)){
      if(
        !all(
          inherits(x = exclude_listing, what = "character"),
          length(exclude_listing) > 0
        ) 
      ){
        stop("'exclude_listing' must be character with positive length.")
      } else if(!all(exclude_listing %in% colnames(x))){
        stop(
          "'exclude_listing' must be column names in 'x': Columns \"",
          paste(
            setdiff(x = exclude_listing, y = colnames(x)),
            collapse = "\", \""
          ),
          "\" do not exist in 'x'."
        )
      }
    }
    
    codebook <-
      data.frame(
        Variable = colnames(x),
        Label = 
          sapply(
            X = x,
            FUN = function(x) {
              x_label <- labelled::var_label(x)
              return(
                ifelse(test = is.null(x_label), yes = "", no = x_label)
              )
            }
          ) %>% as.character,
        Class = as.character(sapply(X = x, FUN = class)),
        Values =
          sapply(
            X = x, 
            FUN = function(x) {
              if(inherits(x = x, what = "factor")){
                paste(levels(x), collapse = "\\\\")
              } else if(inherits(x = x, what = c("numeric", "integer"))){
                class(x)
              }
            }
          ) %>%
          as.character()
      )
    
    if(!is.null(exclude_listing)){
      codebook$Values[which(codebook$Variable %in% exclude_listing)] <-
        "(Not Listed)"
    }
    
    
    
    return(
      codebook %>% 
        tidyr::separate_longer_delim(
          cols = Values,
          delim = "\\\\"
        ) %>% 
        dplyr::mutate(
          row_number = dplyr::row_number(),
          variable_lag = lag(x = Variable, n = 1),
          is_duplicated = 
            dplyr::case_when(
              row_number == 1 ~ FALSE,
              TRUE ~ Variable == variable_lag
            )
        ) %>% 
        dplyr::mutate(
          Variable = case_when(is_duplicated ~ "", !is_duplicated ~ Variable),
          Label = case_when(is_duplicated ~ "", !is_duplicated ~ Label),
          Class = case_when(is_duplicated ~ "", !is_duplicated ~ Class)
        ) %>% 
        dplyr::select(
          Variable, Label, Class, Values
        )
    )
  }