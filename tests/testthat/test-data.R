test_that(
  desc = "Datasets Exist", {
    expect_equal(
      object = class(botox_dystonia),
      expected = "data.frame"
    )

    expect_equal(
      object = class(colon_cancer_active),
      expected = "data.frame"
    )

    expect_equal(
      object = class(colon_cancer_original),
      expected = "data.frame"
    )

    expect_equal(
      object = class(colon_cancer),
      expected = "data.frame"
    )

    expect_equal(
      object = class(indo_rct),
      expected = "data.frame"
    )

    expect_equal(
      object = class(laryngoscope),
      expected = "data.frame"
    )

    expect_equal(
      object = class(licorice_gargle),
      expected = "data.frame"
    )

    expect_equal(
      object = class(lung_cancer),
      expected = "data.frame"
    )

    expect_equal(
      object = class(perio_pregnancy),
      expected = "data.frame"
    )

    expect_equal(
      object = class(strep_tb),
      expected = "data.frame"
    )

    expect_equal(
      object = class(supraclavicular),
      expected = "data.frame"
    )
  }
)
